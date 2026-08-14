import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_app/core/widgets/custom_icon.dart';
import 'package:flutter_math_app/features/scenes/presentation/arcade_game/arcade_game_screen.dart';

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
                    MaterialPageRoute(builder: (_) => ArcadeGameScreen()),
                  );
                },
                child: CustomIcon(assetRoute: 'lib/core/assets/images/play_icon.png'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
