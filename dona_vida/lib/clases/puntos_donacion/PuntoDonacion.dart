class PuntoDonacion {
  String uuid;
  String nombre;
  String direccion;
  String telefono;
  String horario;
  double? latitud;
  double? longitud;

  PuntoDonacion({
    required this.uuid,
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.horario,
    required this.latitud,
    required this.longitud,
  });

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'nombre': nombre,
      'direccion': direccion,
      'telefono': telefono,
      'horario': horario,
      'latitud': latitud,
      'longitud': longitud,
    };
  }

  factory PuntoDonacion.fromJson(Map<String, dynamic> json) {
    return PuntoDonacion(
      uuid: json['uuid'] ?? '',
      nombre: json['nombre'] ?? 'Nombre no disponible',
      direccion: json['direccion'] ?? 'Dirección no disponible',
      telefono: json['telefono'] ?? 'N/A',
      horario: json['horario'] ?? 'N/A',
      latitud: (json['latitud'] as num?)?.toDouble(),
      longitud: (json['longitud'] as num?)?.toDouble(),
    );
  }
}
