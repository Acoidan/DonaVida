import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _loginWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      // Asumimos que el campo 'username' se usa para el email
      String email = _usernameController.text.trim();
      String password = _passwordController.text;
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(
          'Inicio de sesión con Email/Password exitoso: ${userCredential.user?.email}',
        );
        // Aquí puedes navegar a otra pantalla o mostrar un mensaje de éxito
      } on FirebaseAuthException catch (e) {
        print('Error en el inicio de sesión con Email/Password: ${e.message}');
        // Aquí puedes mostrar un mensaje de error al usuario
      } catch (e) {
        print('Ocurrió un error inesperado: $e');
      }
    }
  }

  void _loginWithGoogle() async {
    try {
      await _googleSignIn.signIn();
      // Implement your login logic here
      print('Google Sign-In successful');
    } catch (error) {
      print('Google Sign-In failed: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loginWithEmailAndPassword,
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loginWithGoogle,
                child: Text('Login with Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
