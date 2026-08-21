import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/l10n/arb/app_localizations.dart';
import 'package:flutter_math_app/features/scenes/presentation/shared/widgets/title_phase_row.dart';
import 'package:flutter_math_app/features/tutorial/presentation/cubit/tutorial_cubit.dart';

class TutorialNumberIndicatorRow extends StatelessWidget {
  const TutorialNumberIndicatorRow({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<TutorialCubit, TutorialState>(
      buildWhen: (previous, current) => previous.currentStepIndex != current.currentStepIndex,
      builder: (context, state) {
        return TitlePhaseRow(
          phase: "${context.read<TutorialCubit>().state.currentStepIndex} / ${context.read<TutorialCubit>().state.tutorialSteps}",
          title: l10n.tutorial,
        );
      },
    );
  }
}
