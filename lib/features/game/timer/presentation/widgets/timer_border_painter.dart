import 'dart:math' as math;

import 'package:flutter/material.dart';

class TimerBorderPainter extends CustomPainter {
  static const double radius = 18;
  static const double stroke = 5;
  final double progress;
  TimerBorderPainter({super.repaint, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      stroke / 2,
      stroke / 2,
      size.width - stroke,
      size.height - stroke,
    );

    // Borde de fondo

    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = Colors.white24;

    canvas.drawArc(
      rect,
      0,
      math.pi * 2,
      false,
      backgroundPaint,
    );

    // Color según tiempo

    Color color;

    if (progress > .5) {
      color = Colors.white;
    } else if (progress > .2) {
      color = Colors.amber;
    } else {
      color = Colors.red;
    }

    // Arco de progreso

    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = color;

    canvas.drawArc(
      rect,
      // Empieza arriba
      -math.pi / 2,
      // Sentido horario
      -progress * math.pi * 2,
      false,
      progressPaint,
    );

    // Punta
    final endAngle = -math.pi / 2 - progress * math.pi * 2;
    final center = rect.center;

    final radius = rect.width / 2;
    final tip = Offset(
      center.dx + radius * math.cos(endAngle),
      center.dy + radius * math.sin(endAngle),
    );
    // circle
    final pulse = 1 + 0.25 * math.sin(DateTime.now().millisecondsSinceEpoch / 120);
    canvas.drawCircle(tip, 5 * pulse, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate as TimerBorderPainter).progress != progress;
  }
}
