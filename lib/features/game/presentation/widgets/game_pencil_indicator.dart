import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/widgets/animated_pencil.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_phase.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';

class GamePencilIndicator extends StatelessWidget {
  const GamePencilIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (previous, current) {
        if ((previous.gamePhaseEvent != current.gamePhaseEvent) && current.gamePhaseEvent != null) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return (state.gamePhaseEvent?.gamePhase == GamePhase.newQuestion || state.gamePhaseEvent?.gamePhase == GamePhase.repeatQuestion)
            ? AnimatedPencil()
            : SizedBox.shrink();
      },
    );
  }
}
