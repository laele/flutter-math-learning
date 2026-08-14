import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/core/mixins/event_emitter.dart';
import 'package:flutter_math_app/core/mixins/pausable_actions.dart';
import 'package:flutter_math_app/features/tutorial/domain/constants/tutorial_sequence.dart';
import 'package:flutter_math_app/features/tutorial/domain/entities/tutorial_phase_event.dart';
import 'package:flutter_math_app/features/tutorial/domain/entities/tutorial_step_entity.dart';
import 'package:flutter_math_app/features/tutorial/domain/enums/tutorial_phase.dart';
import 'package:flutter_math_app/features/tutorial/domain/enums/tutorial_step_type.dart';

part 'tutorial_state.dart';

class TutorialCubit extends Cubit<TutorialState> with EventEmitter, PausableActions {
  int _currentStepIndex = 0;

  TutorialCubit() : super(TutorialState());

  void _emitNextTutorialPhaseEvent({required TutorialPhase phase}) {
    emit(
      state.copyWith(
        tutorialPhaseEvent: TutorialPhaseEvent(
          id: nextEventId(),
          phase: phase,
        ),
      ),
    );
  }

  void startTutorial() {
    _currentStepIndex = 0;
    _emitNextTutorialPhaseEvent(phase: TutorialPhase.starting);
    _showCurrentStep();
  }

  void _showCurrentStep() {
    if (_currentStepIndex >= TutorialSequence.steps.length) {
      _emitNextTutorialPhaseEvent(phase: TutorialPhase.finished);
      return;
    }

    final step = TutorialSequence.steps[_currentStepIndex];
    emit(state.copyWith(currentStep: step));

    if (step.expectedResult != null) {
      _emitNextTutorialPhaseEvent(phase: TutorialPhase.waitingInput);
    } else {
      _emitNextTutorialPhaseEvent(phase: TutorialPhase.showingStep);
      pauseFor(_advanceStep);
    }
  }

  void submitAnswer({required int result}) {
    final expected = state.currentStep?.expectedResult;
    if (expected == null) return;

    if (result == expected) {
      _emitNextTutorialPhaseEvent(phase: TutorialPhase.stepCompleted);
      pauseFor(_advanceStep);
    } else {
      _emitNextTutorialPhaseEvent(phase: TutorialPhase.waitingInput);
    }
  }

  void setErrorPhase() {
    _emitNextTutorialPhaseEvent(phase: TutorialPhase.inputError);
    pauseFor(
      () {
        _emitNextTutorialPhaseEvent(phase: TutorialPhase.waitingInput);
      },
    );
  }

  void _advanceStep() {
    _currentStepIndex++;
    _showCurrentStep();
  }
}
