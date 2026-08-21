import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/l10n/arb/app_localizations.dart';
import 'package:flutter_math_app/core/widgets/app_filled_button.dart';

class PlayAgainButton extends StatelessWidget {
  final VoidCallback function;

  const PlayAgainButton({
    super.key,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppFilledButton(title: l10n.playAgain, function: function);
  }
}
