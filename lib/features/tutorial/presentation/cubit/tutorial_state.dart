part of 'tutorial_cubit.dart';

class TutorialState extends Equatable {
  final TutorialPhaseEvent? tutorialPhaseEvent;
  final TutorialStepEntity? currentStep;
  final int? numberRecognized;

  const TutorialState({
    this.tutorialPhaseEvent,
    this.currentStep,
    this.numberRecognized,
  });

  TutorialState copyWith({
    TutorialPhaseEvent? tutorialPhaseEvent,
    TutorialStepEntity? currentStep,
    int? numberRecognized,
  }) {
    return TutorialState(
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
  ];
}
