import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/l10n/arb/app_localizations.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';
import 'package:flutter_math_app/features/scenes/presentation/shared/widgets/title_phase_row.dart';

class PracticeNumberIndicatorRow extends StatelessWidget {
  const PracticeNumberIndicatorRow({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (previous, current) => previous.gameSession.progress != current.gameSession.progress,
      builder: (context, state) {
        return TitlePhaseRow(
          phase: "${context.read<GameCubit>().state.gameSession.questionsAnswered} / ${context.read<GameCubit>().state.gameSession.questionsPerSession}",
          title: l10n.practiceMode,
        );
      },
    );
  }
}
