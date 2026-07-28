import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';

class ScorePlayAgainButton extends StatelessWidget {
  const ScorePlayAgainButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: AppColors.onPrimaryBorder),
      onPressed: () {
        //context.read<GameCubit>().playAgain();
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
