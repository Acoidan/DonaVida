class DonanteDeSangre {
  String uuid;
  String nombre;
  String apellidos;
  String tipoDeSangre = '';
  String telefono;
  String email;
  String direccion;
  String codigoPostal = '';
  String provincia = '';
  String localidad = '';
  String pais = 'España';
  DateTime fechaDeNacimiento;
  DateTime fechaUltimaDonacion = DateTime.now();
  DateTime fechaProximaDonacion = DateTime.now().add(Duration(days: 90));
  DateTime fechaAltaDonante = DateTime.now();
  String tipoDonante = 'Donante de Sangre';
  bool esDonanteActivo;
  String nif;

  DonanteDeSangre({
    required this.uuid,
    required this.nombre,
    required this.apellidos,
    required this.telefono,
    this.email = '',
    required this.direccion,
    required this.fechaDeNacimiento,
    this.esDonanteActivo = true,
    required this.nif
  });

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'nombre': nombre,
      'apellidos': apellidos,
      'tipoDeSangre': tipoDeSangre,
      'telefono': telefono,
      'email': email,
      'direccion': direccion,
      'fechaDeNacimiento': fechaDeNacimiento.toIso8601String(),
      'esDonanteActivo': esDonanteActivo,
      'nif': nif,
    };
  }

  fromJson(Map<String, dynamic> json) {
    return DonanteDeSangre(
      uuid: json['uuid'],
      nombre: json['nombre'],
      apellidos: json['apellidos'],
      telefono: json['telefono'],
      email: json['email'] ?? '',
      direccion: json['direccion'],
      fechaDeNacimiento: DateTime.parse(json['fechaDeNacimiento']),
      esDonanteActivo: json['esDonanteActivo'] ?? true,
      nif: json['nif'],
    )..tipoDeSangre = json['tipoDeSangre'] ?? '';
  }
}
