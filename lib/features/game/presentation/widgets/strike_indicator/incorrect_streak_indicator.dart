import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';
import 'package:flutter_math_app/features/game/presentation/widgets/strike_indicator/incorrect_streak_animated.dart';

class StrikeIndicatorSection extends StatelessWidget {
  const StrikeIndicatorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        final incorrectStreak = state.gameSession.incorrectStreak;

        return IncorrectStreakAnimated(
          isVisible: incorrectStreak > 0,
          incorrectStreak: incorrectStreak,
        );
      },
    );
  }
}
