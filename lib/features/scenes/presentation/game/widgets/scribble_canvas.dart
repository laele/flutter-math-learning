import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/features/dialog_message/cubit/dialog_message_cubit.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';
import 'package:flutter_math_app/features/input_recognition/presentation/input_recognition_cubit/input_recognition_cubit.dart';
import 'package:scribble/scribble.dart';

class ScribbleCanvas extends StatefulWidget {
  const ScribbleCanvas({super.key});

  @override
  State<ScribbleCanvas> createState() => _ScribbleCanvas();
}

class _ScribbleCanvas extends State<ScribbleCanvas> with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );

  late final Animation<double> _fade = Tween<double>(begin: 1, end: 0).animate(
    CurvedAnimation(parent: controller, curve: Curves.bounceInOut),
  );

  late final Animation<double> _scale =
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
          parent: controller,
          curve: const Interval(0.0, 1, curve: Curves.easeOut),
        ),
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> playOutAnimation() async {
    await controller.forward(from: 0);
  }

  void resetAnimation() async {
    controller.reset();
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
        if (state.status == InputRecognitionStatus.processing) {
          if (!mounted) return;
          await playOutAnimation();
          context.read<InputRecognitionCubit>().clearCanvas();
          resetAnimation();
        }
        if (state.isStatusFailure) {
          context.read<DialogMessageCubit>().showMessage(message: state.errorMessage!);
          await Future.delayed(Duration(seconds: 3));
          if (!mounted) return;
          context.read<GameCubit>().showInstructionMessage();
        }
        if (state.status == InputRecognitionStatus.success) {
          context.read<DialogMessageCubit>().showMessage(message: state.numberRecognized!.toString());
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
                animation: controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fade.value,
                    child: Transform.scale(
                      scale: _scale.value,
                      child: BlocBuilder<GameCubit, GameState>(
                        buildWhen: (previous, current) => previous.canDraw != current.canDraw,
                        builder: (context, state) {
                          return IgnorePointer(
                            ignoring: !state.canDraw,
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
