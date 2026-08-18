import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/di/init_dependencies.dart';
import 'package:flutter_math_app/core/l10n/arb/app_localizations.dart';
import 'package:flutter_math_app/core/theme/app_gradients.dart';
import 'package:flutter_math_app/core/widgets/floating_math_symbols_background.dart';
import 'package:flutter_math_app/features/character/presentation/character_rive.dart';
import 'package:flutter_math_app/features/character/presentation/cubit/character_cubit.dart';
import 'package:flutter_math_app/features/scenes/presentation/arcade_game/arcade_game_screen.dart';
import 'package:flutter_math_app/features/scenes/presentation/menu/widgets/menu_button.dart';
import 'package:flutter_math_app/features/scenes/presentation/menu/widgets/menu_canvas.dart';
import 'package:flutter_math_app/features/scenes/presentation/practice_game/practice_game_screen.dart';
import 'package:flutter_math_app/features/scenes/presentation/tutorial/tutorial_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CharacterCubit>(),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: AppGradients.background,
                        ),
                      ),

                      Positioned.fill(
                        child: FloatingMathSymbolsBackground(
                          symbolCount: 35,
                          color: Colors.white,
                          opacity: 0.45,
                        ),
                      ),

                      Align(
                        alignment: AlignmentGeometry.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MenuButton(
                              title: l10n.play,
                              assetIconRoute: 'lib/core/assets/images/play_icon.png',
                              function: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => ArcadeGameScreen()),
                                );
                              },
                            ),
                            MenuButton(
                              title: l10n.practiceMode,
                              assetIconRoute: 'lib/core/assets/images/math_book.png',
                              function: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => PracticeGameScreen()),
                                );
                              },
                            ),
                            MenuButton(
                              title: l10n.tutorial,
                              assetIconRoute: 'lib/core/assets/images/how_to_play_icon.png',
                              function: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => TutorialScreen()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                CharacterRive(),
              ],
            ),
            MenuCanvas(),
          ],
        ),
        //floatingActionButton: MenuFloatingActionButtons(),
      ),
    );
  }
}
