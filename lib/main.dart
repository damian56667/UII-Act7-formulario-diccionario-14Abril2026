import 'package:flutter/material.dart';
import 'inicio.dart';
import 'capturaempleados.dart';
import 'verempleados.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plataforma Antigravity',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
        fontFamily: 'Roboto', // O cualquier otra fuente por defecto atractiva
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Inicio(),
        '/captura': (context) => const CapturaEmpleados(),
        '/ver': (context) => const VerEmpleados(),
      },
    );
  }
}
