import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/core/mixins/event_emitter.dart';
import 'package:flutter_math_app/core/mixins/pausable_actions.dart';
import 'package:flutter_math_app/features/tutorial/domain/constants/tutorial_sequence.dart';
import 'package:flutter_math_app/features/tutorial/domain/entities/tutorial_phase_event.dart';
import 'package:flutter_math_app/features/tutorial/domain/entities/tutorial_step_entity.dart';
import 'package:flutter_math_app/features/tutorial/domain/entities/tutorial_step_event.dart';
import 'package:flutter_math_app/features/tutorial/domain/enums/tutorial_phase.dart';

part 'tutorial_state.dart';

class TutorialCubit extends Cubit<TutorialState>
    with EventEmitter, PausableActions {
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

  void _emitNextTutorialStepEvent({required TutorialStepEntity step}) {
    emit(
      state.copyWith(
        currentStepEvent: TutorialStepEvent(
          id: nextEventId(),
          step: step,
        ),
      ),
    );
  }

  void startTutorial() {
    _emitNextTutorialPhaseEvent(phase: TutorialPhase.starting);
    _showCurrentStep();
  }

  void _showCurrentStep() {
    if (state.currentStepIndex >= TutorialSequence.steps.length) {
      _emitNextTutorialPhaseEvent(phase: TutorialPhase.finished);
      return;
    }
    final step = TutorialSequence.steps[state.currentStepIndex];
    _emitNextTutorialStepEvent(step: step);

    if (step.requiresInput) {
      _emitNextTutorialPhaseEvent(phase: TutorialPhase.waitingInput);
    } else {
      _emitNextTutorialPhaseEvent(phase: TutorialPhase.showingStep);
      pauseFor(_advanceStep);
    }
  }

  void submitAnswer({required int result}) {
    emit(state.copyWith(numberRecognized: result));
    final step = state.currentStepEvent?.step;
    if (step == null || !step.requiresInput) return;

    if (step.expectedResult == null) {
      _emitNextTutorialPhaseEvent(phase: TutorialPhase.correctPracticeDraw);
      pauseFor(_advanceStep);
    } else if (result == step.expectedResult) {
      _emitNextTutorialPhaseEvent(phase: TutorialPhase.correct);
      pauseFor(_advanceStep);
    } else {
      _emitNextTutorialPhaseEvent(phase: TutorialPhase.incorrect);
      pauseFor(_showCurrentStep);
    }
  }

  void setErrorPhase() {
    _emitNextTutorialPhaseEvent(phase: TutorialPhase.inputError);
    pauseFor(_showCurrentStep);
  }

  void _advanceStep() {
    final newIndex = state.currentStepIndex + 1;
    emit(state.copyWith(currentStepIndex: newIndex));
    _showCurrentStep();
  }
}
