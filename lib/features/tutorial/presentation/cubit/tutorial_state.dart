part of 'tutorial_cubit.dart';

class TutorialState extends Equatable {
  final TutorialPhaseEvent? tutorialPhaseEvent;
  final TutorialStepEvent? currentStepEvent;
  final int? numberRecognized;
  final int currentStepIndex;

  const TutorialState({
    this.tutorialPhaseEvent,
    this.currentStepEvent,
    this.numberRecognized,
    this.currentStepIndex = 0,
  });

  double get progress => currentStepIndex == 0
      ? 0
      : (currentStepIndex / TutorialSequence.steps.length);
  int get tutorialSteps => TutorialSequence.steps.length;
  TutorialState copyWith({
    TutorialPhaseEvent? tutorialPhaseEvent,
    TutorialStepEvent? currentStepEvent,
    int? numberRecognized,
    int? currentStepIndex,
  }) {
    return TutorialState(
      currentStepEvent: currentStepEvent ?? this.currentStepEvent,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      numberRecognized: numberRecognized ?? this.numberRecognized,
      tutorialPhaseEvent: tutorialPhaseEvent ?? this.tutorialPhaseEvent,
    );
  }

  @override
  List<Object?> get props => [
    tutorialPhaseEvent,
    currentStepEvent,
    numberRecognized,
    currentStepIndex,
  ];
}
