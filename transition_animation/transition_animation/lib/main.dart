import 'package:flutter/material.dart';
import 'second_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bounce Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // TweenSequence para rebote
    _bounceAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3).chain(CurveTween(curve: Curves.easeOut)), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 0.9).chain(CurveTween(curve: Curves.easeInOut)), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0).chain(CurveTween(curve: Curves.easeIn)), weight: 50),
    ]).animate(_controller);
  }

  void _bounceText() {
    _controller.forward(from: 0); // dispara animación desde el inicio
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texto central que rebota
            AnimatedBuilder(
              animation: _bounceAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _bounceAnimation.value,
                  child: const Text(
                    'Hello',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),

            // Botón que hace rebotar el texto
            ElevatedButton(
              onPressed: _bounceText,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Text('Rebotar Texto', style: TextStyle(fontSize: 18)),
            ),

            const SizedBox(height: 20),

            // Botón para ir a la segunda pantalla
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const SecondScreen(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      var slideTween = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                          .chain(CurveTween(curve: Curves.easeInOut));
                      var fadeTween = Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: Curves.easeIn));
                      var scaleTween = Tween<double>(begin: 0.8, end: 1.0).chain(CurveTween(curve: Curves.elasticOut));

                      return SlideTransition(
                        position: animation.drive(slideTween),
                        child: FadeTransition(
                          opacity: animation.drive(fadeTween),
                          child: ScaleTransition(
                            scale: animation.drive(scaleTween),
                            child: child,
                          ),
                        ),
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 600),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Text('Go to Screen 2', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
