import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_math_app/features/audio/presentation/cubit/audio_cubit.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';
import 'package:flutter_math_app/features/game/presentation/screens/menu/menu_screen.dart';

class HomeFloatingActionButtons extends StatelessWidget {
  const HomeFloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (previous, current) => previous.showMenu != current.showMenu,
      builder: (context, state) {
        if (state.showMenu) {
          // return Game Menu
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
                          context.read<AudioCubit>().playSfxButtonTap();
                          MenuScreen.show(context);
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
                        context.read<AudioCubit>().playSfxButtonTap();
                        context.read<GameCubit>().startGame();
                      },
                      child: Icon(Icons.play_arrow),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          // return Game Mode Menu
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
                          context.read<AudioCubit>().playSfxButtonTap();
                          context.read<GameCubit>().backToMenu();
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: BounceInDown(
                      child: FloatingActionButton(
                        heroTag: 'starsEffectButton',

                        onPressed: () {
                          /*const options = ConfettiOptions(
                            spread: 360,
                            ticks: 50,
                            gravity: 0,
                            decay: 0.94,
                            startVelocity: 30,
                            colors: [Color(0xffFFE400), Color(0xffFFBD00), Color(0xffE89400), Color(0xffFFCA6C), Color(0xffFDFFB8)],
                          );

                          shoot() {
                            Confetti.launch(context, options: options.copyWith(particleCount: 40, scalar: 1.2), particleBuilder: (index) => Star());
                            Confetti.launch(
                              context,
                              options: options.copyWith(
                                particleCount: 10,
                                scalar: 0.75,
                              ),
                              particleBuilder: (index) => Star(),
                            );
                          }

                          Timer(Duration.zero, shoot);
                          Timer(const Duration(milliseconds: 100), shoot);
                          Timer(const Duration(milliseconds: 200), shoot);*/
                        },
                        child: Icon(Icons.stars),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
