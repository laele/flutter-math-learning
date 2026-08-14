import 'package:flutter_math_app/features/tutorial/domain/entities/tutorial_step_entity.dart';
import 'package:flutter_math_app/features/tutorial/domain/enums/tutorial_step_type.dart';

class TutorialSequence {
  static const List<TutorialStepEntity> steps = [
    TutorialStepEntity(type: TutorialStepType.welcome, requiresInput: false),
    TutorialStepEntity(type: TutorialStepType.showingPencil, requiresInput: false),
    TutorialStepEntity(type: TutorialStepType.practiceDraw, requiresInput: true),
    TutorialStepEntity(type: TutorialStepType.practiceAdd, expectedResult: 5, requiresInput: true),
    //TutorialStepEntity(type: TutorialStepType.showScoreExplain),
    TutorialStepEntity(type: TutorialStepType.ready, requiresInput: false),
  ];
}
