import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/widgets/custom_icon.dart';
import 'package:flutter_math_app/features/scenes/presentation/practice_game/widgets/exit_game_dialog.dart';
import 'package:flutter_math_app/features/scenes/presentation/menu/menu_screen.dart';

class PracticeFloatingActionButtons extends StatelessWidget {
  const PracticeFloatingActionButtons({super.key});

  Future<bool> _showExitConfirmation(BuildContext context) async {
    final shouldExit = await showDialog<bool>(context: context, builder: (context) => const ExistGameDialog());

    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: BounceInDown(
                child: FloatingActionButton(
                  heroTag: 'backHomeButton',

                  onPressed: () async {
                    final shouldPop = await _showExitConfirmation(context);
                    if (shouldPop && context.mounted) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MenuScreen()));
                    }
                  },
                  child: CustomIcon(assetRoute: 'lib/core/assets/images/arrow_left.png'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
