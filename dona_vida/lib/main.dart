import 'package:dona_vida/firebase_options.dart';
import 'package:dona_vida/pantallas/login/login.dart';
import 'package:dona_vida/pantallas/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    return MaterialApp(
      title: 'Dona Vida',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginPage(),
      routes: {
        '/menu': (context) => const Menu(),
//        '/pantalla1': (context) => const Pantalla1(),
//        '/pantalla2': (context) => const Pantalla2(),
      },
    );
  }
}
