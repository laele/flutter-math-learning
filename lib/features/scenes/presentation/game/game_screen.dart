import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/di/init_dependencies.dart';
import 'package:flutter_math_app/core/entities/character_animation_type.dart';
import 'package:flutter_math_app/core/theme/app_gradients.dart';
import 'package:flutter_math_app/features/character/presentation/character_rive.dart';
import 'package:flutter_math_app/features/character/presentation/cubit/character_cubit.dart';
import 'package:flutter_math_app/features/dialog_message/cubit/dialog_message_cubit.dart';
import 'package:flutter_math_app/features/dialog_message/presentation/dialog_message_text.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_phase.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';
import 'package:flutter_math_app/features/scenes/presentation/game/widgets/game_fab.dart';
import 'package:flutter_math_app/features/scenes/presentation/game/widgets/scribble_canvas.dart';
import 'package:flutter_math_app/features/scenes/presentation/game/widgets/pencil_sign.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<GameCubit>()),
        BlocProvider(create: (_) => sl<CharacterCubit>()),
        BlocProvider(create: (_) => sl<DialogMessageCubit>()),
      ],
      child: GameView(),
    );
  }
}

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  bool _hasStarted = false;

  void _startGameIfReady() {
    if (_hasStarted) return;

    final characterReady = context.read<CharacterCubit>().state.controllerReady;
    if (characterReady) {
      _hasStarted = true;
      context.read<GameCubit>().generateNextLevel();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback(
      (_) {
        _startGameIfReady(); // check if all was set ready before create widget
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Check if Character is ready TODO change if want to check more than 1 dependency
        BlocListener<CharacterCubit, CharacterState>(
          listenWhen: (previous, current) {
            if (previous.controllerReady != current.controllerReady && current.controllerReady == true) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            _startGameIfReady();
          },
        ),
        BlocListener<GameCubit, GameState>(
          listenWhen: (previous, current) {
            if ((previous.gamePhaseEvent != current.gamePhaseEvent) && current.gamePhaseEvent != null) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            if (state.gamePhaseEvent != null) {
              switch (state.gamePhaseEvent!.gamePhase) {
                case GamePhase.question:
                  context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.thinking);
                  context.read<DialogMessageCubit>().showMessage(
                    message: state.gameQuestionEvent!.indicationMessage,
                    upperMessage: state.gameQuestionEvent!.operationMessage,
                  );
                  return;
                case GamePhase.checkingResult:
                  context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.thinking);
                  context.read<DialogMessageCubit>().showMessage(message: 'Checking result...');
                  return;
                case GamePhase.incorrect:
                  context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.failed);
                  context.read<DialogMessageCubit>().showMessage(message: 'Nope! Try it again!...');
                  return;
                case GamePhase.correct:
                  context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.success);
                  context.read<DialogMessageCubit>().showMessage(message: 'Correct!...');
                  return;
                case GamePhase.skipByIncorrect:
                  context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.failed);
                  context.read<DialogMessageCubit>().showMessage(message: 'Let\'s skip this one...');
                  return;
                case GamePhase.error:
                  context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.failed);
                  context.read<DialogMessageCubit>().showMessage(message: 'What was that?...');
                  return;
                case GamePhase.explanation:
                  context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.thinking);
                  context.read<DialogMessageCubit>().showMessage(message: '${state.gameQuestionEvent!.explanationMessage}...');
                  return;
                case GamePhase.finished:
                  context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.success);
                  context.read<DialogMessageCubit>().showMessage(message: 'That was fun! Wanna play again?...');
                  return;
                case GamePhase.starting:
                  break;
                case (_):
                  break;
              }
            }
          },
        ),
      ],

      child: Scaffold(
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
                      Align(alignment: AlignmentGeometry.center, child: PencilSign()),
                      Align(alignment: AlignmentGeometry.bottomCenter, child: DialogMessageText()),
                    ],
                  ),
                ),

                CharacterRive(),
              ],
            ),
            ScribbleCanvas(),
          ],
        ),

        floatingActionButton: GameFloatingActionButtons(),
      ),
    );
  }
}
