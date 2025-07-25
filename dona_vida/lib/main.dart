import 'package:dona_vida/firebase_options.dart';
import 'package:dona_vida/pantallas/informacion/informacion.dart';
import 'package:dona_vida/pantallas/login/login.dart';
import 'package:dona_vida/pantallas/calendarioDonaciones/calendarioDoncaiones.dart';
import 'package:dona_vida/pantallas/menu/menu.dart';
import 'package:dona_vida/pantallas/puntosDonacion/puntosDonacion.dart';
import 'package:dona_vida/pantallas/puntosDonacion/verInformacionPuntoInformacion.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dona Vida',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return const Menu();
          }
          return const LoginPage();
        },
      ),
      routes: {
        '/menu': (context) => const Menu(),
        '/calendarioDonaciones': (context) => const CalendarioDonaciones(),
        '/puntosDonacion': (context) => const PuntosDonacionScreen(),
        '/informacion': (context) => const InformacionScreen(),
        '/login': (context) => const LoginPage(),

      },
    );
  }
}
