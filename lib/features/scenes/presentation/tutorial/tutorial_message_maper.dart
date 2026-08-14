// scenes/presentation/tutorial/tutorial_message_mapper.dart
import 'package:flutter_math_app/features/dialog_message/domain/enums/message_key_type.dart';
import 'package:flutter_math_app/features/tutorial/domain/enums/tutorial_step_type.dart';

class TutorialMessageMapper {
  static MessageKeyType keyFor(TutorialStepType type) => switch (type) {
    TutorialStepType.welcome => MessageKeyType.tutorialWelcome,
    TutorialStepType.showingPencil => MessageKeyType.tutorialShowPencil,
    TutorialStepType.practiceDraw => MessageKeyType.tutorialPracticeDraw,
    TutorialStepType.practiceAdd => MessageKeyType.tutorialPracticeAdd,
    TutorialStepType.showScoreExplain => MessageKeyType.tutorialShowScore,
    TutorialStepType.ready => MessageKeyType.tutorialReady,
    TutorialStepType.incorrect => MessageKeyType.incorrect,
    TutorialStepType.correct => MessageKeyType.correct,
    TutorialStepType.correctPracticeDraw => MessageKeyType.tutorialCorrectPracticeDraw,
    TutorialStepType.error => MessageKeyType.error,
  };
}
