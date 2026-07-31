import 'package:flutter/material.dart';
import 'package:flutter_math_app/features/game/timer/presentation/timer_indicator.dart';

class GameTopBar extends StatelessWidget {
  const GameTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerIndicator(),
          ],
        ),
      ),
    );
  }
}
