import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/features/audio/domain/enums/sound_type.dart';
import 'package:flutter_math_app/features/audio/presentation/cubit/audio_cubit.dart';

class AudioListener extends StatelessWidget {
  final Widget child;
  const AudioListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AudioCubit, AudioState>(
      listenWhen: (previous, current) {
        if (previous.soundEvent != current.soundEvent &&
            current.soundEvent != null) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        switch (state.soundEvent!.type) {
          case SoundType.correct:
            context.read<AudioCubit>().playSfxCorrect();
            return;
          case SoundType.incorrect:
            context.read<AudioCubit>().playSfxIncorrect();
            return;
          case _:
            return;
        }
      },
      child: child,
    );
  }
}
