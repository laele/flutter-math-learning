import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_math_app/core/di/init_dependencies.dart';
import 'package:flutter_math_app/features/audio/domain/enums/sound_type.dart';
import 'package:flutter_math_app/features/audio/presentation/cubit/audio_cubit.dart';
import 'package:flutter_math_app/features/character/domain/enums/character_animation_type.dart';
import 'package:flutter_math_app/core/theme/app_gradients.dart';
import 'package:flutter_math_app/features/character/presentation/character_rive.dart';
import 'package:flutter_math_app/features/character/presentation/cubit/character_cubit.dart';
import 'package:flutter_math_app/features/dialog_message/domain/enums/message_key_type.dart';
import 'package:flutter_math_app/features/dialog_message/presentation/cubit/dialog_message_cubit.dart';
import 'package:flutter_math_app/features/dialog_message/presentation/dialog_message_text.dart';
import 'package:flutter_math_app/features/effects/domain/enums/effect_type.dart';
import 'package:flutter_math_app/features/effects/presentation/cubit/effects_cubit.dart';
import 'package:flutter_math_app/features/effects/presentation/effects_layer.dart';
import 'package:flutter_math_app/features/effects/presentation/widgets/shake_widget.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_phase.dart';
import 'package:flutter_math_app/features/game/domain/services/game_rules_policy.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';
import 'package:flutter_math_app/features/scenes/presentation/practice_game/widgets/practice_game_top_bar.dart';
import 'package:flutter_math_app/features/scenes/presentation/shared/widgets/game_message_mapper.dart';
import 'package:flutter_math_app/features/scenes/presentation/arcade_game/score_overlay.dart';
import 'package:flutter_math_app/features/input_recognition/presentation/input_recognition_cubit/input_recognition_cubit.dart';
import 'package:flutter_math_app/features/scenes/presentation/arcade_game/widgets/game_fab.dart';
import 'package:flutter_math_app/features/scenes/presentation/shared/widgets/scribble_canvas.dart';
import 'package:flutter_math_app/features/game/presentation/widgets/pencil_sign.dart';

class PracticeGameScreen extends StatelessWidget {
  const PracticeGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<GameCubit>(param1: PracticeRulesPolicy())),
        BlocProvider(create: (_) => sl<CharacterCubit>()),
        BlocProvider(create: (_) => sl<DialogMessageCubit>()),
        BlocProvider(create: (_) => sl<EffectsCubit>()),
      ],
      child: PracticeGameView(),
    );
  }
}

class PracticeGameView extends StatefulWidget {
  const PracticeGameView({super.key});

  @override
  State<PracticeGameView> createState() => _PracticeGameViewState();
}

class _PracticeGameViewState extends State<PracticeGameView> {
  bool _hasStarted = false;
  bool _firstCompleted = false;
  Timer? _nextActionTimer;

  static const _phaseTimings = <GamePhase, Duration>{
    GamePhase.incorrect: Duration(seconds: 5),
    GamePhase.starting: Duration(seconds: 3),
    GamePhase.correct: Duration(seconds: 5),
    GamePhase.newQuestion: Duration(seconds: 1),
    GamePhase.repeatQuestion: Duration(seconds: 1),
    GamePhase.skipByIncorrect: Duration(seconds: 5),
    GamePhase.explanation: Duration(seconds: 5),
    GamePhase.error: Duration(seconds: 5),
  };

  void _waitForNextAction({required GamePhase gamePhase}) {
    _nextActionTimer?.cancel();
    final duration = _phaseTimings[gamePhase];

    if (duration == null) {
      return;
    }
    _nextActionTimer = Timer(duration, () {
      if (!mounted) return;
      context.read<GameCubit>().continueAction();
    });
  }

  void _startGameIfReady() {
    if (_hasStarted) return;

    final characterReady = context.read<CharacterCubit>().state.controllerReady;
    if (characterReady) {
      _hasStarted = true;
      context.read<GameCubit>().initGame();
    }
  }

  @override
  void dispose() {
    _nextActionTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<InputRecognitionCubit>().clearCanvas();
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
            final gamePhase = state.gamePhaseEvent!.gamePhase;
            switch (gamePhase) {
              case GamePhase.newQuestion:
                context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.thinking);
                context.read<DialogMessageCubit>().showMessageByKey(
                  key: GameMessageMapper.messageKeyFor(state.gameQuestionEvent!.gameMode),
                  upperMessage: state.gameQuestionEvent!.operationMessage,
                );
                break;
              case GamePhase.repeatQuestion:
                context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.thinking);
                context.read<DialogMessageCubit>().showMessageByKey(
                  key: GameMessageMapper.messageKeyFor(state.gameQuestionEvent!.gameMode),
                  upperMessage: state.gameQuestionEvent!.operationMessage,
                );
                break;
              case GamePhase.checkingResult:
                context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.thinking);
                context.read<DialogMessageCubit>().showMessageByKey(
                  key: MessageKeyType.thinking,
                );
                break;
              case GamePhase.incorrect:
                context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.failed);
                context.read<DialogMessageCubit>().showMessageByKey(key: MessageKeyType.incorrect);
                context.read<EffectsCubit>().playEffect(effect: EffectsType.shake);
                context.read<AudioCubit>().playSound(soundType: SoundType.incorrect);
                break;
              case GamePhase.correct:
                if (!_firstCompleted) _firstCompleted = true;
                context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.success);
                context.read<DialogMessageCubit>().showMessageByKey(key: MessageKeyType.correct);
                context.read<EffectsCubit>().playEffect(effect: EffectsType.stars);
                context.read<EffectsCubit>().playEffect(effect: EffectsType.shake);
                context.read<AudioCubit>().playSound(soundType: SoundType.correct);
                break;
              case GamePhase.skipByIncorrect:
                context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.failed);
                context.read<DialogMessageCubit>().showMessageByKey(key: MessageKeyType.skipByIncorrect);
                context.read<EffectsCubit>().playEffect(effect: EffectsType.shake);
                context.read<AudioCubit>().playSound(soundType: SoundType.incorrect);
                break;
              case GamePhase.error:
                context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.failed);
                context.read<DialogMessageCubit>().showMessageByKey(key: MessageKeyType.error);
                context.read<EffectsCubit>().playEffect(effect: EffectsType.shake);
                context.read<AudioCubit>().playSound(soundType: SoundType.incorrect);
                break;
              case GamePhase.explanation:
                context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.thinking);
                context.read<DialogMessageCubit>().showMessageByKey(key: MessageKeyType.explanation, upperMessage: ' --- ');
                break;
              case GamePhase.finished:
                _firstCompleted = false;
                context.read<CharacterCubit>().playCharacterAnimation(CharacterAnimationType.success);
                context.read<DialogMessageCubit>().showMessageByKey(key: MessageKeyType.finished);
                context.read<EffectsCubit>().playEffect(effect: EffectsType.confetti);
                context.read<EffectsCubit>().playEffect(effect: EffectsType.shake);
                break;
              case GamePhase.starting:
                context.read<DialogMessageCubit>().showMessageByKey(key: MessageKeyType.starting);
                break;
              case (_):
                break;
            }
            _waitForNextAction(gamePhase: gamePhase);
          },
        ),
      ],

      child: Scaffold(
        body: ShakeWidget(
          child: Stack(
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
                        /*Align(
                          alignment: AlignmentGeometry.center,
                          child: ScoreOverlay(),
                        ),*/
                        Align(alignment: AlignmentGeometry.bottomCenter, child: DialogMessageText()),
                      ],
                    ),
                  ),

                  CharacterRive(),
                ],
              ),
              ScribbleCanvas(),
              PracticeGameTopBar(),
              EffectsLayer(),
            ],
          ),
        ),

        floatingActionButton: GameFloatingActionButtons(),
      ),
    );
  }
}
