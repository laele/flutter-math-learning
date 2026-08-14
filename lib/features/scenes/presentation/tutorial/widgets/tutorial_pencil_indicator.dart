import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/widgets/animated_pencil.dart';
import 'package:flutter_math_app/features/tutorial/domain/enums/tutorial_phase.dart';
import 'package:flutter_math_app/features/tutorial/presentation/cubit/tutorial_cubit.dart';

class TutorialPencilIndicator extends StatelessWidget {
  const TutorialPencilIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TutorialCubit, TutorialState>(
      buildWhen: (previous, current) {
        if ((previous.tutorialPhaseEvent != current.tutorialPhaseEvent) && current.tutorialPhaseEvent != null) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return (state.tutorialPhaseEvent?.phase == TutorialPhase.waitingInput) ? AnimatedPencil() : SizedBox.shrink();
      },
    );
  }
}
