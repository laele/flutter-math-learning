import 'package:flutter/material.dart';
import 'package:flutter_math_app/features/scenes/presentation/practice_game/widgets/incorrect_streak_indicator.dart';

class PracticeGameTopBar extends StatelessWidget {
  const PracticeGameTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentGeometry.topCenter,
                child: StrikeIndicatorSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
