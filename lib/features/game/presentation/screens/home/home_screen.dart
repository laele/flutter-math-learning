import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/effects/widgets/shake_widget.dart';

class HomeScreen extends StatelessWidget {
  final shakeKey = GlobalKey<ShakeWidgetState>();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //sl<EffectsPlayer>().registerShakeTarget(shakeKey);
    return /*GameEffectListener(
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
        child:*/ Scaffold(
      body: Stack(
        children: [
          //ShakeWidget(key: shakeKey, child: HomeMascotBackground()),
        ],
      ),
    );
  }
}
