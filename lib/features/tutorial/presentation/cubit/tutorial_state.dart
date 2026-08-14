part of 'tutorial_cubit.dart';

class TutorialState extends Equatable {
  final TutorialPhaseEvent? tutorialPhaseEvent;
  final TutorialStepEntity? currentStep;
  final int? numberRecognized;
  final int currentStepIndex;

  const TutorialState({this.tutorialPhaseEvent, this.currentStep, this.numberRecognized, this.currentStepIndex = 0});

  double get progress => currentStepIndex == 0 ? 0 : (currentStepIndex / TutorialSequence.steps.length);

  TutorialState copyWith({
    TutorialPhaseEvent? tutorialPhaseEvent,
    TutorialStepEntity? currentStep,
    int? numberRecognized,
    int? currentStepIndex,
  }) {
    return TutorialState(
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      numberRecognized: numberRecognized ?? this.numberRecognized,
      tutorialPhaseEvent: tutorialPhaseEvent ?? this.tutorialPhaseEvent,
      currentStep: currentStep ?? this.currentStep,
    );
  }

  @override
  List<Object?> get props => [
    tutorialPhaseEvent,
    currentStep,
    numberRecognized,
    currentStepIndex,
  ];
}
