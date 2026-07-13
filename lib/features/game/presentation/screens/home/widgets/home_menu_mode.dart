import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/features/game/domain/constants/game_modes.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_mode_entity.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';

class HomeMenuMode extends StatelessWidget {
  const HomeMenuMode({super.key});

  @override
  Widget build(BuildContext context) {
    final gameModesList = GameModes.items;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 160,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 1 / 1,
        ),
        itemCount: gameModesList.length,
        itemBuilder: (context, index) => MenuButton(gameMode: gameModesList[index]),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final GameModeEntity gameMode;
  const MenuButton({super.key, required this.gameMode});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        context.read<GameCubit>().startGameBySelectedMode(gameMode: gameMode.gameMode);
      },
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(45.0)),
        backgroundColor: Colors.orange,
      ),
      child: Text(
        gameMode.title,
        textAlign: TextAlign.center,
      ),
    );
  }
}
