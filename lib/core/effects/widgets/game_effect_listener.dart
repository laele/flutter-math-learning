import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/effects/effects_player.dart';
import 'package:flutter_math_app/core/effects/game_effect_type.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';

/*
class GameEffectListener extends StatelessWidget {
  final Widget child;
  final EffectsPlayer effectsPlayer;
  const GameEffectListener({super.key, required this.child, required this.effectsPlayer});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameCubit, GameState>(
      listenWhen: (previous, current) {
        if ((previous.effectEvent != current.effectEvent) && current.effectEvent != null) return true;
        return false;
      },
      listener: (context, state) {
        for (final type in state.effectEvent!.type) {
          effectsPlayer.play(type, context);
        }
      },
      child: child,
    );
  }
}*/
