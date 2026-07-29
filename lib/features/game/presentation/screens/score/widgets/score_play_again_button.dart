import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';

class ScorePlayAgainButton extends StatelessWidget {
  const ScorePlayAgainButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: AppColors.onPrimaryBorder),
      onPressed: () {
        context.read<GameCubit>().initGame();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Play Again'),
        ],
      ),
    );
  }
}
