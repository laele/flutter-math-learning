import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/constants/app_game.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';

class AttemptCounterSection extends StatelessWidget {
  const AttemptCounterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<GameCubit, GameState>(
        buildWhen: (previous, current) {
          if ((previous.gameSession != current.gameSession) && current.gameSession != null) {
            return true;
          }
          return false;
        },
        builder: (BuildContext context, GameState state) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('${state.gameSession.questionsAnswered} / ${AppGame.questionsPerSession}')],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('${state.gameSession.incorrectStreak} / ${AppGame.maxIncorectStreak}')],
              ),
            ],
          );
        },
      ),
    );
  }
}
