import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/theme/app_gradients.dart';
import 'package:flutter_math_app/features/character/domain/enums/character_animation_type.dart';
import 'package:flutter_math_app/features/character/presentation/cubit/character_cubit.dart';
import 'package:rive/rive.dart';

class CharacterRive extends StatefulWidget {
  const CharacterRive({super.key});

  @override
  State<CharacterRive> createState() => _CharacterRiveState();
}

class _CharacterRiveState extends State<CharacterRive> {
  late final FileLoader fileLoader;

  RiveWidgetController? _controller;
  TriggerInput? _triggerSuccess;
  TriggerInput? _triggerFailed;
  TriggerInput? _triggerThinking;

  @override
  void initState() {
    super.initState();
    fileLoader = FileLoader.fromAsset('lib/core/assets/rive/greg_the_frog.riv', riveFactory: Factory.rive);
  }

  @override
  void dispose() {
    fileLoader.dispose();
    super.dispose();
  }

  void _animationState(CharacterAnimationType petAnimation) {
    switch (petAnimation) {
      case (CharacterAnimationType.success):
        _triggerSuccess?.fire();
        break;
      case (CharacterAnimationType.failed):
        _triggerFailed?.fire();
        break;
      case (CharacterAnimationType.thinking):
        _triggerThinking?.fire();
        break;
      case _:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CharacterCubit, CharacterState>(
      listenWhen: (previous, current) {
        if (previous.animationEvent != current.animationEvent && current.animationEvent != null) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        _animationState(state.animationEvent!.type);
      },

      child: SizedBox(
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: RiveWidgetBuilder(
            fileLoader: fileLoader,
            builder: (context, state) => switch (state) {
              RiveLoading() => Container(
                decoration: BoxDecoration(
                  gradient: AppGradients.loadingBackgroundRive,
                ),
                child: Center(child: CircularProgressIndicator()),
              ),
              RiveFailed() => Container(
                decoration: BoxDecoration(
                  gradient: AppGradients.loadingBackgroundRive,
                ),
              ),
              RiveLoaded() => Builder(
                builder: (context) {
                  if (_controller != state.controller) {
                    _controller = state.controller;
                    _triggerSuccess = state.controller.stateMachine.trigger('Hi');

                    _triggerFailed = state.controller.stateMachine.trigger('Annoyed');
                    _triggerThinking = state.controller.stateMachine.trigger('Curious');
                  }
                  context.read<CharacterCubit>().setControllerReady(); // notitfy controller is ready
                  return RiveWidget(controller: state.controller, fit: Fit.cover);
                },
              ),
            },
          ),
        ),
      ),
    );
  }
}
