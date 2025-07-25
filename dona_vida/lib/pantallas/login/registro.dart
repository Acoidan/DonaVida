import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dona_vida/clases/usuario/donanteDeSangre.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Controladores para los campos del formulario
  final _nombreController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _direccionController = TextEditingController();
  final _fechaNacimientoController = TextEditingController();
  final _nifController = TextEditingController();

  DateTime? _selectedDate;

  @override
  void dispose() {
    // Limpiar controladores
    _nombreController.dispose();
    _apellidosController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _direccionController.dispose();
    _fechaNacimientoController.dispose();
    _nifController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Crear usuario en Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());

      User? user = userCredential.user;

      if (user != null) {
        // 2. Crear objeto DonanteDeSangre
        final nuevoDonante = DonanteDeSangre(
          nombre: _nombreController.text.trim(),
          apellidos: _apellidosController.text.trim(),
          telefono: _telefonoController.text.trim(),
          email: _emailController.text.trim(),
          direccion: _direccionController.text.trim(),
          fechaDeNacimiento: _selectedDate!,
          nif: _nifController.text.trim(), 
          uuid: user.uid
        );

        // 3. Guardar datos en Firestore
        await FirebaseFirestore.instance
            .collection('donantes')
            .doc(user.uid)
            .set(nuevoDonante.toJson());

        // Mostrar mensaje de éxito y volver a la pantalla de login
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registro completado con éxito.')),
          );
          Navigator.of(context).pop();
        }
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Ocurrió un error durante el registro.';
      if (e.code == 'weak-password') {
        message = 'La contraseña es demasiado débil.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Ya existe una cuenta con este correo electrónico.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _fechaNacimientoController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Crear Cuenta', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red.shade800,
              Colors.red.shade400,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: kToolbarHeight), // Space for AppBar
                  _buildTextFormField(_nombreController, 'Nombre', Icons.person_outline, validator: (v) => v!.isEmpty ? 'Campo requerido' : null),
                  const SizedBox(height: 16),
                  _buildTextFormField(_apellidosController, 'Apellidos', Icons.person_outline, validator: (v) => v!.isEmpty ? 'Campo requerido' : null),
                  const SizedBox(height: 16),
                  _buildTextFormField(_emailController, 'Correo Electrónico', Icons.email_outlined, keyboardType: TextInputType.emailAddress, validator: (v) => v!.isEmpty || !v.contains('@') ? 'Correo inválido' : null),
                  const SizedBox(height: 16),
                  _buildTextFormField(_passwordController, 'Contraseña', Icons.lock_outline, obscureText: true, validator: (v) => v!.length < 6 ? 'Mínimo 6 caracteres' : null),
                  const SizedBox(height: 16),
                  _buildTextFormField(_telefonoController, 'Teléfono', Icons.phone_outlined, keyboardType: TextInputType.phone, validator: (value) => value!.isEmpty ? 'Campo requerido' : null),
                  const SizedBox(height: 16),
                  _buildTextFormField(_direccionController, 'Dirección', Icons.home_outlined, validator: (value) => value!.isEmpty ? 'Campo requerido' : null),
                  const SizedBox(height: 16),
                  _buildTextFormField(_fechaNacimientoController, 'Fecha de Nacimiento', Icons.calendar_today_outlined, readOnly: true, onTap: () => _selectDate(context), validator: (value) => _selectedDate == null ? 'Campo requerido' : null),
                  const SizedBox(height: 16),
                  _buildTextFormField(_nifController, 'NIF', Icons.badge_outlined, validator: (value) => value!.isEmpty ? 'Campo requerido' : null),
                  const SizedBox(height: 32),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator(color: Colors.white))
                      : ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.red.shade700,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('REGISTRAR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      '¿Ya tienes cuenta? Inicia sesión',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool obscureText = false,
    bool readOnly = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function()? onTap,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: _buildInputDecoration(label, icon),
      obscureText: obscureText,
      readOnly: readOnly,
      keyboardType: keyboardType,
      validator: validator,
      onTap: onTap,
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.yellow.shade700),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.yellow.shade700, width: 2),
      ),
    );
  }
}