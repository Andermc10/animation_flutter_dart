import 'package:flutter/material.dart';
import 'dart:math' as math; // Para usar PI en la rotación

// Pantalla principal con animaciones explícitas
class ExplicitAnimationPage extends StatefulWidget {
  @override
  _ExplicitAnimationPageState createState() => _ExplicitAnimationPageState();
}

// State: aquí vive la lógica de las animaciones
class _ExplicitAnimationPageState extends State<ExplicitAnimationPage>
    with SingleTickerProviderStateMixin {
  
  // Controlador y animaciones
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;     // Tamaño
  late Animation<Color?> _colorAnimation;    // Color
  late Animation<double> _rotationAnimation; // Rotación
  late Animation<Offset> _positionAnimation; // Posición

  @override
  void initState() {
    super.initState();
    // Controlador: duración 2s
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Definimos cada animación con su Tween y curva
    _sizeAnimation = Tween<double>(begin: 50.0, end: 150.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );

    _colorAnimation = ColorTween(begin: Colors.blue, end: Colors.red).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _positionAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0, 100)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Liberar memoria
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Animación Explícita - Container')),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Zona donde se ve la animación
          Expanded(
            child: Center(
              child: AnimatedBuilder(
                animation: _controller, // Escucha cambios
                builder: (context, child) {
                  return Transform.translate(
                    offset: _positionAnimation.value,
                    child: Transform.rotate(
                      angle: _rotationAnimation.value * math.pi * 2, // Rotación completa
                      child: Container(
                        width: _sizeAnimation.value,
                        height: _sizeAnimation.value,
                        decoration: BoxDecoration(
                          color: _colorAnimation.value,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Flutter',
                            style: TextStyle(
                              color: Colors.white, 
                              fontWeight: FontWeight.bold, 
                              fontSize: 16
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Panel inferior: controles y barra de progreso
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const Text(
                  'Control de Animación Explícita', 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue)
                ),
                const SizedBox(height: 15),
                
                // Barra de progreso que refleja el avance
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) => Column(
                    children: [
                      Text(
                        'Progreso: ${(_controller.value * 100).toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: _controller.value, 
                        backgroundColor: Colors.grey[300], 
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightBlue),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Botones para controlar la animación
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildButton('Play', Colors.green, () => _controller.forward()),
                    _buildButton('Reverse', Colors.orange, () => _controller.reverse()),
                    _buildButton('Reset', Colors.blue, () => _controller.reset()),
                    _buildButton('Repeat', Colors.purple, () => _controller.repeat()),
                    _buildButton('Stop', Colors.red, () => _controller.stop()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Método auxiliar: crea botones de forma uniforme
  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color, 
        foregroundColor: Colors.white, 
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(text),
    );
  }
}
