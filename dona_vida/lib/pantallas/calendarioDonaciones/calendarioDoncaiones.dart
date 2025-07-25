import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dona_vida/clases/donacion.dart';
import 'package:dona_vida/clases/usuario/donanteDeSangre.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioDonaciones extends StatefulWidget {
  const CalendarioDonaciones({super.key});

  @override
  State<CalendarioDonaciones> createState() => _CalendarioDonacionesState();
}

class _CalendarioDonacionesState extends State<CalendarioDonaciones> {
  // Usamos un Map para almacenar los eventos. La clave es la fecha y el valor es una lista de eventos.
  late Map<DateTime, List<Donacion>> _events;

  final User? _currentUser = FirebaseAuth.instance.currentUser;
  DonanteDeSangre? _donanteActual;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Donacion> _selectedEvents = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _events = {};
    if (_currentUser != null) {
      _fetchDonanteData();
      _fetchDonations();
    }
  }

  Future<void> _fetchDonanteData() async {
    if (_currentUser == null) return;
    try {
      final doc = await FirebaseFirestore.instance
          .collection('donantes')
          .doc(_currentUser!.uid)
          .get();
      if (doc.exists && mounted) {
        setState(() { 
          _donanteActual = DonanteDeSangre(uuid: '', nombre: '', apellidos: '', telefono: '', direccion: '', fechaDeNacimiento: DateTime.now(), nif: '').fromJson(doc.data()!);
        });
      }
    } catch (e) {
      debugPrint("Error al obtener datos del donante: $e");
    }
  }

  void _fetchDonations() {
    if (_currentUser == null) return;

    FirebaseFirestore.instance
        .collection('donaciones')
        .where('donanteUuid', isEqualTo: _currentUser!.uid)
        .snapshots()
        .listen((snapshot) {
      final Map<DateTime, List<Donacion>> fetchedEvents = {};
      for (var doc in snapshot.docs) {
        try {
          final donacion = Donacion.fromJson(doc.data());
          final day = DateTime.utc(donacion.fechaDonacion.year,
              donacion.fechaDonacion.month, donacion.fechaDonacion.day);
          fetchedEvents.putIfAbsent(day, () => []).add(donacion);
        } catch (e) {
          debugPrint("Error al parsear donación: ${doc.data()}, error: $e");
        }
      }
      if (mounted) {
        setState(() {
          _events = fetchedEvents;
          _selectedEvents = _getEventsForDay(_selectedDay!);
        });
      }
    });
  }

  List<Donacion> _getEventsForDay(DateTime day) {
    // Normalizamos el día para que coincida con las claves del Map.
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents = _getEventsForDay(selectedDay);
      });
    }
  }

  Future<void> _addDonation(BuildContext context) async {
    if (_currentUser == null || _selectedDay == null) return;

    String? lugarDonacion = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String lugar = '';
        return AlertDialog(
          title: const Text('Añadir Lugar de Donación'),
          content: TextField(
            onChanged: (text) {
              lugar = text;
            },
            decoration: const InputDecoration(hintText: 'Escribe aquí'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(lugar);
              },
            ),
          ],
        );
      },
    );

    if (lugarDonacion != null && lugarDonacion.isNotEmpty) {
      final newDonationId =
          FirebaseFirestore.instance.collection('donaciones').doc().id;
      final tipoSangre = _donanteActual?.tipoDeSangre ?? 'Desconocido';

      final donacion = Donacion(
        uuid: newDonationId,
        tipoDeSangre: tipoSangre,
        fechaDonacion: _selectedDay!,
        donanteUuid: _currentUser!.uid,
        puntoDonacion: lugarDonacion,
      );

      await FirebaseFirestore.instance
          .collection('donaciones')
          .doc(newDonationId)
          .set(donacion.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario de Donaciones'),
      ),
      body: Column(
        children: [
          TableCalendar<Donacion>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
            eventLoader: _getEventsForDay,
            calendarStyle: const CalendarStyle(
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedEvents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_selectedEvents[index].puntoDonacion),
                  subtitle: Text(
                      'Tipo de sangre: ${_selectedEvents[index].tipoDeSangre}\nEstado: ${_selectedEvents[index].estado}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addDonation(context),
        tooltip: 'Añadir Donación',
        child: const Icon(Icons.add),
        backgroundColor: Colors.red, // Puedes personalizar el color
        foregroundColor: Colors.white, // Puedes personalizar el color
        elevation: 5, // Puedes personalizar la elevación
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}