import 'package:flutter/material.dart';
import 'package:flutter_math_app/features/game/presentation/widgets/session_progress/game_session_progress_indicator_bar.dart';
import 'package:flutter_math_app/features/game/presentation/widgets/strike_indicator/incorrect_streak_indicator.dart';

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
                child: Column(
                  children: [
                    GameSessionProgressIndicatorBar(),
                    SizedBox(height: 16),
                    StrikeIndicatorSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
