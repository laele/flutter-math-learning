import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/effects/effects_player.dart';
import 'package:flutter_math_app/core/effects/game_effect_type.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';

class GameEffectListener extends StatelessWidget {
  final Widget child;
  final EffectsPlayer effectsPlayer;
  const GameEffectListener({super.key, required this.child, required this.effectsPlayer});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameCubit, GameState>(
      listenWhen: (previous, current) {
        if ((previous.gameEffect != current.gameEffect) && current.gameEffect != null) return true;
        return false;
      },
      listener: (context, state) {
        switch (state.gameEffect!.type) {
          case GameEffectType.stars:
            effectsPlayer.play(GameEffectType.stars, context);
          case GameEffectType.confetti:
            effectsPlayer.play(GameEffectType.confetti, context);
          case _:
            break;
        }
        ;
      },
      child: child,
    );
  }
}
