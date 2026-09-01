import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_math_app/core/l10n/arb/app_localizations.dart';

class ExistGameDialog extends StatelessWidget {
  const ExistGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16.0),
      ),
      title: Text(
        l10n.exitGame,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        l10n.progressNotWillSave,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(l10n.exit),
        ),
      ],
    );
  }
}
