import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';

class GameSessionProgressIndicatorBar extends StatelessWidget {
  const GameSessionProgressIndicatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (previous, current) {
        if (previous.gameSession.questionsAnswered != current.gameSession.questionsAnswered) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        final progress = state.gameSession.progress;
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: progress),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
          builder: (BuildContext context, double value, Widget? child) {
            return CustomPaint(
              size: const Size(double.infinity, 17),
              foregroundPainter: ProgressBarPainter(progress: value, trackColor: Colors.black38, fillColor: AppColors.primary),
            );
          },
        );
      },
    );
  }
}

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
