import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/di/init_dependencies.dart';
import 'package:flutter_math_app/core/effects/effects_player.dart';
import 'package:flutter_math_app/core/effects/widgets/game_effect_listener.dart';
import 'package:flutter_math_app/core/effects/widgets/shake_widget.dart';
import 'package:flutter_math_app/features/audio/presentation/cubit/audio_cubit.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_sound_event.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';
import 'package:flutter_math_app/features/game/presentation/screens/home/widgets/home_action_buttons.dart';
import 'package:flutter_math_app/features/game/presentation/screens/home/widgets/home_mascot_background.dart';
import 'package:flutter_math_app/features/game/presentation/screens/home/widgets/home_play_canvas.dart';

class HomeScreen extends StatelessWidget {
  final shakeKey = GlobalKey<ShakeWidgetState>();
  final GlobalKey<HomePlayCanvasState> homePlayCanvasKey = GlobalKey<HomePlayCanvasState>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sl<EffectsPlayer>().registerShakeTarget(shakeKey);
    return GameEffectListener(
      effectsPlayer: sl<EffectsPlayer>(),
      child: BlocListener<GameCubit, GameState>(
        listenWhen: (previous, current) {
          if (current.soundEvent != null && current.soundEvent != previous.soundEvent) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          final audioCubit = context.read<AudioCubit>();
          switch (state.soundEvent!.type) {
            case GameSoundType.correct:
              audioCubit.playSfxCorrect();
            case GameSoundType.incorrect:
              audioCubit.playSfxIncorrect();
            case GameSoundType.levelUp:
              audioCubit.playSfxCorrect(); // o un playSfxLevelUp() dedicado, si agregas ese SFX
            case GameSoundType.levelDown:
              audioCubit.playSfxIncorrect();
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              ShakeWidget(key: shakeKey, child: HomeMascotBackground()),
              /*SafeArea(
                child: BlocBuilder<GameCubit, GameState>(
                  buildWhen: (previous, current) {
                    return previous.stats != current.stats;
                  },
                  builder: (context, state) {
                    return Wrap(
                      children: state.stats.entries
                          .map(
                            (e) => Column(
                              children: [
                                Text('gameMode: ${e.key.name}'),
                                Text('registry: ${e.value.recentResults}'),
                                Text('attempts Streak: ${e.value.attempts}'),
                                Text('correct count: ${e.value.correctCount}'),
                                Text('error Rate: ${e.value.errorRate}'),
                                Text('nivel ${e.value.currentTierIndex}'),
                                SizedBox(height: 10),
                              ],
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ),*/
              HomePlayCanvas(key: homePlayCanvasKey),
            ],
          ),
          floatingActionButton: HomeFloatingActionButtons(),
        ),
      ),
    );
  }
}
