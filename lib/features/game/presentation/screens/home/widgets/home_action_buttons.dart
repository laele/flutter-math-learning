import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';
import 'package:flutter_math_app/features/input_recognition/presentation/input_recognition_cubit/input_recognition_cubit.dart';

class HomeFloatingActionButtons extends StatelessWidget {
  const HomeFloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<GameCubit, GameState>(
          buildWhen: (previous, current) => previous.gameMode != current.gameMode,
          builder: (context, state) {
            if (state.gameMode != GameMode.menu) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        context.read<GameCubit>().backToMenu();
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
        /*Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<InputRecognitionCubit>().clearCanvas();
              },
              child: Icon(Icons.delete),
            ),
          ],
        ),*/
      ],
    );
  }
}
