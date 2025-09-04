import 'package:flutter/material.dart';
import 'explicit_animation_page.dart'; // Importar tu página

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animaciones Explícitas Flutter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ExplicitAnimationPage(), // Navegar a tu página
      debugShowCheckedModeBanner: false,
    );
  }
}