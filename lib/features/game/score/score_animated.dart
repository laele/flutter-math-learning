import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';
import 'package:flutter_math_app/features/game/score/widgets/text_score_animated.dart';

class ScoreAnimated extends StatelessWidget {
  const ScoreAnimated({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (previous, current) => previous.gameSession.correctCount != current.gameSession.correctCount,
      builder: (context, state) {
        return BounceInDown(
          child: Container(
            width: 80,
            height: 80,
            clipBehavior: Clip.none,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Image.asset(
                    'lib/core/assets/images/star.png',
                    color: Colors.white,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextScoreAnimated(
                      scoreText: '${state.gameSession.correctCount * 2}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
