import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_phase.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';
import 'package:flutter_math_app/features/game/score/cubit/score_cubit.dart';
import 'package:flutter_math_app/features/game/score/widgets/play_again_button.dart';
import 'package:flutter_math_app/core/widgets/score_badge.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/cubit/player_profile_cubit.dart';

class ScoreOverlay extends StatefulWidget {
  const ScoreOverlay({super.key});

  @override
  State<ScoreOverlay> createState() => _ScoreOverlayState();
}

class _ScoreOverlayState extends State<ScoreOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scale = TweenSequence<double>(
      [
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 40),
      ],
    ).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 1)));

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 1.0)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> playInAnimation() async {
    await _controller.forward(from: 0);
  }

  Future<void> playOutAnimation() async {
    await _controller.reverse(from: 1);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<GameCubit, GameState>(
      listenWhen: (previous, current) => (previous.gamePhaseEvent != current.gamePhaseEvent) && current.gamePhaseEvent != null,
      listener: (context, state) async {
        if (state.gamePhaseEvent!.gamePhase == GamePhase.finished) {
          playInAnimation();
        }
      },
      buildWhen: (previous, current) => (previous.gamePhaseEvent != current.gamePhaseEvent) && current.gamePhaseEvent != null,

      builder: (context, state) {
        return (state.gamePhaseEvent?.gamePhase == GamePhase.finished)
            ? AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fade.value,
                    child: Transform.scale(
                      scale: _scale.value,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 300, maxHeight: 500),
                            child: Card(
                              color: colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(36.0),
                              ),
                              elevation: 25,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
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
                                                'Game Over!',
                                                textStyle: textTheme.displayLarge,
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Your Score',
                                          style: Theme.of(context).textTheme.titleLarge,
                                        ),
                                        SizedBox(width: 8),
                                        ScoreBadge(
                                          widthSize: 75,
                                          heightSize: 75,
                                          child: FittedBox(child: Text(context.read<ScoreCubit>().state.currentScore.toString())),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Best',
                                          style: Theme.of(context).textTheme.titleLarge,
                                        ),
                                        SizedBox(width: 8),
                                        ScoreBadge(
                                          widthSize: 75,
                                          heightSize: 75,
                                          child: FittedBox(child: Text(context.read<PlayerProfileCubit>().state.profile.bestArcadeScore.toString())),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    FittedBox(
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
                                                'New Score!',
                                                textStyle: textTheme.displayLarge,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    //StarsSection(accuracy: state.gameSession.accuracy),
                                    SizedBox(height: 8.0),

                                    SizedBox(height: 12.0),
                                    PlayAgainButton(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : SizedBox.shrink();
      },
    );
  }
}
