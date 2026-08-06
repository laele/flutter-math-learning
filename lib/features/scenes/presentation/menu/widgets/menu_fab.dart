import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_app/features/scenes/presentation/game/game_screen.dart';

class MenuFloatingActionButtons extends StatelessWidget {
  const MenuFloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox.shrink(),
        BounceInDown(
          delay: Duration(milliseconds: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'playButton',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => GameScreen()),
                  );
                },
                child: SizedBox(
                  height: 16,
                  width: 16,
                  child: Image.asset('lib/core/assets/images/play_icon.png'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
