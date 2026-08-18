import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/l10n/arb/app_localizations.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';

class PlayAgainButton extends StatelessWidget {
  final VoidCallback function;

  const PlayAgainButton({
    super.key,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: AppColors.onPrimaryBorder),
      onPressed: function,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(l10n.playAgain),
        ],
      ),
    );
  }
}
