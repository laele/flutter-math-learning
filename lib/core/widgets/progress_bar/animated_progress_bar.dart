import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:flutter_math_app/core/widgets/progress_bar/progress_bar_painter.dart';

class AnimatedProgresBar extends StatelessWidget {
  final double progress;
  final Color trackColor;
  final Color fillColor;

  const AnimatedProgresBar({super.key, required this.progress, this.trackColor = Colors.black38, this.fillColor = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: this.progress),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (BuildContext context, double value, Widget? child) {
        return CustomPaint(
          size: const Size(double.infinity, 17),
          foregroundPainter: ProgressBarPainter(
            progress: value,
            trackColor: trackColor,
            fillColor: fillColor,
          ),
        );
      },
    );
  }
}
