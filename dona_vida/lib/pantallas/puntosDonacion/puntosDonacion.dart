import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dona_vida/clases/puntos_donacion/PuntoDonacion.dart';
import 'package:dona_vida/pantallas/puntosDonacion/verInformacionPuntoInformacion.dart';
import 'package:flutter/material.dart';

class PuntosDonacionScreen extends StatelessWidget {
  const PuntosDonacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centros de Donación'),
        backgroundColor: Colors.red.shade700,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('puntosDonacion').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text('No hay centros de donación disponibles.'));
          }

          final puntosDonacion = snapshot.data!.docs.map((doc) {
            return PuntoDonacion.fromJson(doc.data() as Map<String, dynamic>);
          }).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: puntosDonacion.length,
            itemBuilder: (context, index) {
              final punto = puntosDonacion[index];
              return Card(
                elevation: 4,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(Icons.local_hospital,
                      color: Colors.red.shade700, size: 40),
                  title: Text(
                    punto.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(punto.direccion),
                      const SizedBox(height: 4),
                      Text('Horario: ${punto.horario}'),
                      Text('Teléfono: ${punto.telefono}'),
                      ButtonBar(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => VerInformacionPuntoDonacion(
                                  puntoDonacion: punto,
                                ),
                              ));
                            },
                            child: const Text('Ver Información'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

