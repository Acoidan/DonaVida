class Donacion {
  late final String uuid;
  late final String tipoDeSangre;
  late final DateTime fechaDonacion;
  late final String donanteUuid;
  late final String puntoDonacion;
  late final String observaciones;
  late final String estado; // 'pendiente', 'completada', 'cancelada'
  late final DateTime fechaCreacion;
  late final DateTime fechaModificacion;

  Donacion({
    required this.uuid,
    required this.tipoDeSangre,
    required this.fechaDonacion,
    required this.donanteUuid,
    required this.puntoDonacion,
    this.observaciones = '',
    this.estado = 'pendiente',
  })  : fechaCreacion = DateTime.now(),
        fechaModificacion = DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'tipoDeSangre': tipoDeSangre,
      'fechaDonacion': fechaDonacion.toIso8601String(),
      'donanteUuid': donanteUuid, 
      'puntoDonacion': puntoDonacion,
      'observaciones': observaciones,
      'estado': estado,
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'fechaModificacion': fechaModificacion.toIso8601String(),
    };
  }

  Donacion.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        tipoDeSangre = json['tipoDeSangre'],
        fechaDonacion = DateTime.parse(json['fechaDonacion']),
        donanteUuid = json['donanteUuid'],
        puntoDonacion = json['puntoDonacion'],
        observaciones = json['observaciones'] ?? '',
        estado = json['estado'] ?? 'pendiente',
        fechaCreacion = DateTime.parse(json['fechaCreacion']),
        fechaModificacion = DateTime.parse(json['fechaModificacion']);
  
}