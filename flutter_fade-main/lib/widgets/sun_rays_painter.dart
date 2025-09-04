// widgets/sun_rays_painter.dart
import 'package:flutter/material.dart';
import 'dart:math' show cos, sin;

class SunRaysPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * (3.14159 / 180);
      final startX = center.dx + (radius + 10) * cos(angle);
      final startY = center.dy + (radius + 10) * sin(angle);
      final endX = center.dx + (radius + 25) * cos(angle);
      final endY = center.dy + (radius + 25) * sin(angle);

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}