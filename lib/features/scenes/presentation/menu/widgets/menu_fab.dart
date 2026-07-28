import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_app/features/scenes/presentation/game/game_screen.dart';
import 'package:flutter_math_app/features/scenes/presentation/menu/widgets/menu_moddal_bottom_sheet.dart';

class MenuFloatingActionButtons extends StatelessWidget {
  const MenuFloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BounceInDown(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: FloatingActionButton(
                  heroTag: 'menuButton',
                  onPressed: () {
                    MenuModdalBottomSheet.show(context);
                  },
                  child: Icon(Icons.menu),
                ),
              ),
            ],
          ),
        ),

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
                child: Icon(Icons.play_arrow),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
