import 'package:flutter/material.dart';
import 'package:flutter_math_app/features/game/score/score_animated.dart';
import 'package:flutter_math_app/features/game/timer/presentation/timer_indicator.dart';

class GameTopBar extends StatelessWidget {
  const GameTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Align(alignment: AlignmentGeometry.topRight, child: ScoreAnimated()),
              Align(alignment: AlignmentGeometry.topCenter, child: TimerIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
