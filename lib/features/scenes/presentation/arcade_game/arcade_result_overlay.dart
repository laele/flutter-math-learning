import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/l10n/arb/app_localizations.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:flutter_math_app/core/widgets/animated_overlay.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_phase.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';
import 'package:flutter_math_app/features/game/score/cubit/score_cubit.dart';
import 'package:flutter_math_app/features/game/score/widgets/play_again_button.dart';
import 'package:flutter_math_app/core/widgets/score_badge.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/cubit/player_profile_cubit.dart';

class ArcadeResultOverlay extends StatefulWidget {
  const ArcadeResultOverlay({super.key});

  @override
  State<ArcadeResultOverlay> createState() => _AracdeResultOverlayState();
}

class _AracdeResultOverlayState extends State<ArcadeResultOverlay> {
  final GlobalKey<AnimatedOverlayState> _animatedOverlayKey = GlobalKey<AnimatedOverlayState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (previous, current) => (previous.gamePhaseEvent != current.gamePhaseEvent) && current.gamePhaseEvent != null,
      builder: (context, state) {
        return (state.gamePhaseEvent?.gamePhase == GamePhase.finished)
            ? AnimatedOverlay(
                key: _animatedOverlayKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedTextKit(
                            pause: Duration(
                              milliseconds: 200,
                            ),
                            repeatForever: true,
                            isRepeatingAnimation: true,
                            animatedTexts: [
                              WavyAnimatedText(
                                l10n.gameOver,
                                textStyle: textTheme.displayLarge!.copyWith(
                                  fontFamily: 'Gocake',
                                  color: AppColors.titleOnPrimary,
                                ),
                                speed: Duration(
                                  milliseconds: 300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    context.read<PlayerProfileCubit>().state.profile.bestArcadeScore == context.read<ScoreCubit>().state.currentScore
                        ? FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedTextKit(
                                  pause: Duration(
                                    milliseconds: 200,
                                  ),
                                  repeatForever: false,
                                  isRepeatingAnimation: false,
                                  animatedTexts: [
                                    BounceAnimatedText(
                                      l10n.newScore,
                                      textStyle: textTheme.displayLarge,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                    SizedBox(height: 8.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.yourScore,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge,
                        ),
                        SizedBox(width: 8),
                        ScoreBadge(
                          showBackground: true,
                          widthSize: 50,
                          heightSize: 50,
                          text: context.read<ScoreCubit>().state.currentScore.toString(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.best,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge,
                        ),
                        SizedBox(width: 8),
                        ScoreBadge(
                          showBackground: true,
                          widthSize: 50,
                          heightSize: 50,
                          text: context.read<PlayerProfileCubit>().state.profile.bestArcadeScore.toString(),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.0),
                    PlayAgainButton(
                      function: () async {
                        await _animatedOverlayKey.currentState?.playOutAnimation();
                        ();
                        if (!mounted) return;
                        context.read<GameCubit>().initGame();
                      },
                    ),
                  ],
                ),
              )
            : SizedBox.shrink();
      },
    );
  }
}
