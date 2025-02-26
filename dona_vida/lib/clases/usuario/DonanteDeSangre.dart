class DonanteDeSangre {
  String nombre;
  String apellido;
  String tipoDeSangre;
  String telefono;
  String email;
  String direccion;
  DateTime fechaDeNacimiento;
  bool esDonanteActivo;
  String nif;

  DonanteDeSangre({
    required this.nombre,
    required this.apellido,
    required this.tipoDeSangre,
    required this.telefono,
    this.email = '',
    required this.direccion,
    required this.fechaDeNacimiento,
    this.esDonanteActivo = true,
    required this.nif,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'tipoDeSangre': tipoDeSangre,
      'telefono': telefono,
      'email': email,
      'direccion': direccion,
      'fechaDeNacimiento': fechaDeNacimiento.toIso8601String(),
      'esDonanteActivo': esDonanteActivo,
      'nif': nif,
    };
  }
}
