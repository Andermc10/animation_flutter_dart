import 'package:flutter/material.dart';
import 'sidebar_menu.dart';

void main() {
  runApp(const AstroStarApp());
}

class AstroStarApp extends StatelessWidget {
  const AstroStarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AstroStar Sidebar',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AstroStar"),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const SidebarMenu(),
      body: const Center(
        child: Text(
          "Contenido principal aquí",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}