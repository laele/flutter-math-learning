import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_phase_event.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_phase.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';
import 'package:flutter_math_app/features/input_recognition/presentation/input_recognition_cubit/input_recognition_cubit.dart';
import 'package:scribble/scribble.dart';

class GameScribbleCanvas extends StatefulWidget {
  const GameScribbleCanvas({super.key});

  @override
  State<GameScribbleCanvas> createState() => _GameScribbleCanvas();
}

class _GameScribbleCanvas extends State<GameScribbleCanvas> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scale =
        TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween(
              begin: 1.0,
              end: 0.6,
            ).chain(CurveTween(curve: Curves.easeIn)),
            weight: 15,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: 0.96,
              end: 1.6,
            ).chain(CurveTween(curve: Curves.easeOut)),
            weight: 45,
          ),
          TweenSequenceItem(
            tween: Tween(
              begin: 1.6,
              end: 2.0,
            ).chain(CurveTween(curve: Curves.easeOut)),
            weight: 40,
          ),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 1, curve: Curves.easeOut),
          ),
        );

    _fade = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> playOutAnimation() async {
    await _controller.forward(from: 0);
  }

  void resetAnimation() async {
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    final inputRecognitionCubit = context.read<InputRecognitionCubit>();
    final canvasWidth = MediaQuery.sizeOf(context).width;
    final canvasHeight = MediaQuery.sizeOf(context).height;
    return BlocListener<InputRecognitionCubit, InputRecognitionState>(
      listenWhen: (previous, current) {
        if (previous.status != current.status) {
          return true;
        }
        return false;
      },
      listener: (context, state) async {
        final isQuestionGamePhase =
            (context.read<GameCubit>().state.gamePhaseEvent?.gamePhase == GamePhase.newQuestion ||
            context.read<GameCubit>().state.gamePhaseEvent?.gamePhase == GamePhase.repeatQuestion);

        if (state.status == InputRecognitionStatus.processing) {
          await playOutAnimation();
          if (!mounted) return;
          context.read<InputRecognitionCubit>().clearCanvas();
          resetAnimation();
        }
        if (state.isStatusFailure && isQuestionGamePhase) {
          context.read<GameCubit>().setErrorGamePhase();
        }
        if (state.status == InputRecognitionStatus.success && isQuestionGamePhase) {
          context.read<GameCubit>().checkResult(result: state.numberRecognized!);
        }
      },
      child: Listener(
        onPointerDown: (_) {
          inputRecognitionCubit.onStartedStroke();
        },
        onPointerUp: (_) {
          inputRecognitionCubit.onFinishedStroke(canvasHeight: canvasHeight, canvasWidth: canvasWidth);
        },
        child: Column(
          children: [
            Expanded(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fade.value,
                    child: Transform.scale(
                      scale: _scale.value,
                      child: BlocBuilder<GameCubit, GameState>(
                        buildWhen: (previous, current) => (previous.gamePhaseEvent != current.gamePhaseEvent) && current.gamePhaseEvent != null,
                        builder: (context, state) {
                          context.read<InputRecognitionCubit>().clearCanvas(); // clear canvas for each gamePhase changed
                          return IgnorePointer(
                            ignoring: state.gamePhaseEvent?.gamePhase != GamePhase.newQuestion && state.gamePhaseEvent?.gamePhase != GamePhase.repeatQuestion,
                            child: Scribble(
                              notifier: inputRecognitionCubit.notifier,
                              drawPen: true,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
