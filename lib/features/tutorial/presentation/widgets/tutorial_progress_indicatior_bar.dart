import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/widgets/progress_bar/animated_progress_bar.dart';
import 'package:flutter_math_app/features/tutorial/presentation/cubit/tutorial_cubit.dart';

class TutorialProgressIndicatiorBar extends StatelessWidget {
  const TutorialProgressIndicatiorBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TutorialCubit, TutorialState>(
      buildWhen: (previous, current) {
        if (previous.progress != current.progress) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        final progress = state.progress;
        return AnimatedProgresBar(progress: progress);
      },
    );
  }
}
