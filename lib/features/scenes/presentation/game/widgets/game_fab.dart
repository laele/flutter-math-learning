import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_app/features/scenes/presentation/menu/menu_screen.dart';

class GameFloatingActionButtons extends StatelessWidget {
  const GameFloatingActionButtons({super.key});

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

                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => MenuScreen()),
                    );
                  },
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
