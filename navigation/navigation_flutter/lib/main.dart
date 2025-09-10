import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navegación Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Pantalla1(),
    );
  }
}

// ---------------- Pantalla 1 ----------------
class Pantalla1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla 1 - Inicio')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Pantalla2()),
            );
          },
          child: const Text('Ir a la Pantalla 2'),
        ),
      ),
    );
  }
}

// ---------------- Pantalla 2 ----------------
class Pantalla2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Volver a Pantalla 1
              },
              child: const Text('Volver a Pantalla 1'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Pantalla3()),
                );
              },
              child: const Text('Ir a Pantalla 3'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Pantalla 3 ----------------
class Pantalla3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla 3')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Regresa a Pantalla 2
          },
          child: const Text('Volver a Pantalla 2'),
        ),
      ),
    );
  }
}
