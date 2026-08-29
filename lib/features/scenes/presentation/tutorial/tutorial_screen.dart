import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/di/init_dependencies.dart';
import 'package:flutter_math_app/core/theme/app_gradients.dart';
import 'package:flutter_math_app/core/widgets/custom_icon.dart';
import 'package:flutter_math_app/features/audio/domain/enums/sound_type.dart';
import 'package:flutter_math_app/features/audio/presentation/cubit/audio_cubit.dart';
import 'package:flutter_math_app/features/character/domain/enums/character_animation_type.dart';
import 'package:flutter_math_app/features/character/presentation/character_rive.dart';
import 'package:flutter_math_app/features/character/presentation/cubit/character_cubit.dart';
import 'package:flutter_math_app/features/dialog_message/presentation/cubit/dialog_message_cubit.dart';
import 'package:flutter_math_app/features/dialog_message/presentation/dialog_message_text.dart';
import 'package:flutter_math_app/features/effects/domain/enums/effect_type.dart';
import 'package:flutter_math_app/features/effects/presentation/cubit/effects_cubit.dart';
import 'package:flutter_math_app/features/effects/presentation/effects_layer.dart';
import 'package:flutter_math_app/features/effects/presentation/widgets/shake_widget.dart';
import 'package:flutter_math_app/features/input_recognition/presentation/input_recognition_cubit/input_recognition_cubit.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/cubit/player_profile_cubit.dart';
import 'package:flutter_math_app/features/scenes/presentation/arcade_game/widgets/game_fab.dart';
import 'package:flutter_math_app/features/scenes/presentation/menu/menu_screen.dart';
import 'package:flutter_math_app/features/scenes/presentation/shared/widgets/tutorial_scribble_canvas.dart';
import 'package:flutter_math_app/features/scenes/presentation/tutorial/tutorial_message_maper.dart';
import 'package:flutter_math_app/features/scenes/presentation/tutorial/widgets/tutorial_pencil_indicator.dart';
import 'package:flutter_math_app/features/scenes/presentation/tutorial/widgets/tutorial_top_bar.dart';
import 'package:flutter_math_app/features/tutorial/domain/enums/tutorial_phase.dart';
import 'package:flutter_math_app/features/tutorial/domain/enums/tutorial_step_type.dart';
import 'package:flutter_math_app/features/tutorial/presentation/cubit/tutorial_cubit.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<TutorialCubit>()),
        BlocProvider(create: (_) => sl<CharacterCubit>()),
        BlocProvider(create: (_) => sl<DialogMessageCubit>()),
        BlocProvider(create: (_) => sl<EffectsCubit>()),
      ],
      child: TutorialView(),
    );
  }
}

class TutorialView extends StatefulWidget {
  const TutorialView({super.key});

  @override
  State<TutorialView> createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView> {
  bool _hasStarted = false;
  bool _showPencilSign = false;
  bool _showSkipStep = true;
  Timer? _nextActionTimer;

  void _startTutorialIfReady() {
    if (_hasStarted) return;

    final characterReady = context.read<CharacterCubit>().state.controllerReady;
    if (characterReady) {
      _hasStarted = true;
      context.read<TutorialCubit>().startTutorial();
    }
  }

  @override
  void dispose() {
    _nextActionTimer?.cancel();
    super.dispose();
  }

  void _waitForNextAction() {
    setState(() {
      _showSkipStep = false;
    });
    _nextActionTimer?.cancel();
    final duration = Duration(seconds: 4);

    _nextActionTimer = Timer(duration, () {
      if (!mounted) return;
      context.read<TutorialCubit>().continueAction();
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<InputRecognitionCubit>().clearCanvas();
    WidgetsBinding.instance.addPersistentFrameCallback(
      (_) {
        _startTutorialIfReady(); // check if all was set ready before create widget
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CharacterCubit, CharacterState>(
          listenWhen: (previous, current) {
            if (previous.controllerReady != current.controllerReady &&
                current.controllerReady == true) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            _startTutorialIfReady();
          },
        ),

        BlocListener<TutorialCubit, TutorialState>(
          listenWhen: (previous, current) {
            final bool isTutorialPhaseChanged =
                previous.tutorialPhaseEvent != current.tutorialPhaseEvent;
            if ((isTutorialPhaseChanged) &&
                current.tutorialPhaseEvent != null &&
                current.currentStepEvent != null) {
              return true;
            }
            return false;
          },
          listener: (context, state) async {
            final playerName = context
                .read<PlayerProfileCubit>()
                .state
                .profile
                .playerName;

            switch (state.tutorialPhaseEvent!.phase) {
              case TutorialPhase.inputError:
                context.read<EffectsCubit>().playEffect(
                  effect: EffectsType.shake,
                );
                context.read<AudioCubit>().playSound(
                  soundType: SoundType.incorrect,
                );
                context.read<CharacterCubit>().playCharacterAnimation(
                  CharacterAnimationType.failed,
                );
                context.read<DialogMessageCubit>().showMessageByKey(
                  key: TutorialMessageMapper.keyFor(TutorialStepType.error),
                  playerName: playerName,
                );
                _waitForNextAction();
                return;
              case TutorialPhase.incorrect:
                context.read<EffectsCubit>().playEffect(
                  effect: EffectsType.shake,
                );
                context.read<AudioCubit>().playSound(
                  soundType: SoundType.incorrect,
                );
                context.read<CharacterCubit>().playCharacterAnimation(
                  CharacterAnimationType.failed,
                );
                context.read<DialogMessageCubit>().showMessageByKey(
                  key: TutorialMessageMapper.keyFor(TutorialStepType.incorrect),
                  playerName: playerName,
                );
                _waitForNextAction();
                return;
              case TutorialPhase.correct:
                context.read<EffectsCubit>().playEffect(
                  effect: EffectsType.stars,
                );
                context.read<EffectsCubit>().playEffect(
                  effect: EffectsType.shake,
                );
                context.read<AudioCubit>().playSound(
                  soundType: SoundType.correct,
                );
                context.read<CharacterCubit>().playCharacterAnimation(
                  CharacterAnimationType.success,
                );
                context.read<DialogMessageCubit>().showMessageByKey(
                  key: TutorialMessageMapper.keyFor(TutorialStepType.correct),
                  playerName: playerName,
                );
                _waitForNextAction();
                return;
              case TutorialPhase.correctPracticeDraw:
                context.read<EffectsCubit>().playEffect(
                  effect: EffectsType.stars,
                );
                context.read<EffectsCubit>().playEffect(
                  effect: EffectsType.shake,
                );
                context.read<AudioCubit>().playSound(
                  soundType: SoundType.correct,
                );
                context.read<CharacterCubit>().playCharacterAnimation(
                  CharacterAnimationType.success,
                );
                context.read<DialogMessageCubit>().showMessageByKey(
                  key: TutorialMessageMapper.keyFor(
                    TutorialStepType.correctPracticeDraw,
                  ),
                  playerName: playerName,
                  number: state.numberRecognized.toString(),
                );
                _waitForNextAction();
                return;
              case TutorialPhase.stepCompleted:
                _waitForNextAction();
                return;
              case TutorialPhase.finished:
                if (state.currentStepEvent?.step.type ==
                    TutorialStepType.ready) {
                  await Future.delayed(Duration(seconds: 2));
                  if (!mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => MenuScreen()),
                  );
                }
                return;
              case TutorialPhase.showingStep:
                if (state.currentStepEvent?.step.type ==
                    TutorialStepType.ready) {
                  _waitForNextAction();
                }
              case (_):
                break;
            }
          },
        ),

        BlocListener<TutorialCubit, TutorialState>(
          listenWhen: (previous, current) {
            final bool isTutorialStepChanged =
                (previous.currentStepEvent != current.currentStepEvent) &&
                current.currentStepEvent != null;
            if ((isTutorialStepChanged) && current.tutorialPhaseEvent != null) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            final playerName = context
                .read<PlayerProfileCubit>()
                .state
                .profile
                .playerName;

            switch (state.currentStepEvent?.step.type) {
              case TutorialStepType.welcome:
                context.read<CharacterCubit>().playCharacterAnimation(
                  CharacterAnimationType.success,
                );
                context.read<DialogMessageCubit>().showMessageByKey(
                  key: TutorialMessageMapper.keyFor(TutorialStepType.welcome),
                  playerName: playerName,
                );
                break;
              case TutorialStepType.showingPencil:
                context.read<DialogMessageCubit>().showMessageByKey(
                  key: TutorialMessageMapper.keyFor(
                    TutorialStepType.showingPencil,
                  ),
                  playerName: playerName,
                );
                context.read<CharacterCubit>().playCharacterAnimation(
                  CharacterAnimationType.success,
                );
                setState(() {
                  _showPencilSign = true;
                });
                break;
              case TutorialStepType.practiceDraw:
                setState(() {
                  _showSkipStep = false;
                });
                context.read<DialogMessageCubit>().showMessageByKey(
                  key: TutorialMessageMapper.keyFor(
                    TutorialStepType.practiceDraw,
                  ),
                  playerName: playerName,
                );
                context.read<CharacterCubit>().playCharacterAnimation(
                  CharacterAnimationType.thinking,
                );

                break;
              case TutorialStepType.practiceAdd:
                context.read<CharacterCubit>().playCharacterAnimation(
                  CharacterAnimationType.thinking,
                );
                context.read<DialogMessageCubit>().showMessageByKey(
                  key: TutorialMessageMapper.keyFor(
                    TutorialStepType.practiceAdd,
                  ),
                  upperMessage: '2 + 3',
                  playerName: playerName,
                );
                break;
              case TutorialStepType.ready:
                setState(() {
                  _showSkipStep = true;
                });
                context.read<EffectsCubit>().playEffect(
                  effect: EffectsType.confetti,
                );
                context.read<EffectsCubit>().playEffect(
                  effect: EffectsType.shake,
                );
                context.read<CharacterCubit>().playCharacterAnimation(
                  CharacterAnimationType.success,
                );
                context.read<DialogMessageCubit>().showMessageByKey(
                  key: TutorialMessageMapper.keyFor(TutorialStepType.ready),
                  playerName: playerName,
                );
                break;
              case (_):
                break;
            }
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

                        _showPencilSign
                            ? Align(
                                alignment: AlignmentGeometry.center,
                                child: TutorialPencilIndicator(),
                              )
                            : SizedBox.shrink(),
                        Align(
                          alignment: AlignmentGeometry.bottomCenter,
                          child: DialogMessageText(),
                        ),
                      ],
                    ),
                  ),

                  CharacterRive(),
                ],
              ),
              TutorialScribbleCanvas(),

              TutorialTopBar(),
              _showSkipStep
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: AlignmentGeometry.centerRight,
                        child: FloatingActionButton(
                          onPressed: () async {
                            context.read<TutorialCubit>().continueAction();
                          },
                          child: CustomIcon(
                            assetRoute:
                                'lib/core/assets/images/arrow_right.png',
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              EffectsLayer(),
            ],
          ),
        ),

        floatingActionButton: GameFloatingActionButtons(),
      ),
    );
  }
}
