import 'package:dona_vida/clases/puntos_donacion/PuntoDonacion.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VerInformacionPuntoDonacion extends StatelessWidget {
  final PuntoDonacion puntoDonacion;

  const VerInformacionPuntoDonacion({super.key, required this.puntoDonacion});

  @override
  Widget build(BuildContext context) {
    final LatLng? initialCameraPosition = (puntoDonacion.latitud != null && puntoDonacion.longitud != null)
        ? LatLng(puntoDonacion.latitud!, puntoDonacion.longitud!)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(puntoDonacion.nombre),
        backgroundColor: Colors.red.shade700,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: initialCameraPosition != null
                ? GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: initialCameraPosition,
                      zoom: 15,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId(puntoDonacion.uuid),
                        position: initialCameraPosition,
                        infoWindow: InfoWindow(title: puntoDonacion.nombre),
                      ),
                    },
                  )
                : const Center(
                    child: Text('Ubicación no disponible'),
                  ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(Icons.location_on, 'Dirección:', puntoDonacion.direccion),
                  _buildInfoRow(Icons.phone, 'Teléfono:', puntoDonacion.telefono),
                  _buildInfoRow(Icons.access_time, 'Horario:', puntoDonacion.horario),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.red.shade700),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$label $value',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}