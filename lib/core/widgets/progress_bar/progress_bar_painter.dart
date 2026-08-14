import 'package:flutter/widgets.dart';

class ProgressBarPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color fillColor;
  ProgressBarPainter({
    super.repaint,
    required this.progress,
    required this.trackColor,
    required this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = Radius.circular(size.height / 2);

    final trackRect = RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), radius);
    final trackPaint = Paint()..color = trackColor;
    canvas.drawRRect(trackRect, trackPaint);

    final fillWidth = size.width * progress.clamp(0.0, 1.0);
    if (fillWidth <= 0) return;

    final fillRect = RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, fillWidth, size.height), radius);

    final fillPaint = Paint()..color = fillColor;

    canvas.save();
    canvas.clipRRect(trackRect);
    canvas.drawRRect(fillRect, fillPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate as ProgressBarPainter).progress != progress;
  }
}
