part of 'tutorial_cubit.dart';

class TutorialState extends Equatable {
  final TutorialPhaseEvent? tutorialPhaseEvent;
  final TutorialStepEntity? currentStep;

  const TutorialState({
    this.tutorialPhaseEvent,
    this.currentStep,
  });

  TutorialState copyWith({
    TutorialPhaseEvent? tutorialPhaseEvent,
    TutorialStepEntity? currentStep,
  }) {
    return TutorialState(
      tutorialPhaseEvent: tutorialPhaseEvent ?? this.tutorialPhaseEvent,
      currentStep: currentStep ?? this.currentStep,
    );
  }

  @override
  List<Object?> get props => [
    tutorialPhaseEvent,
    currentStep,
  ];
}
