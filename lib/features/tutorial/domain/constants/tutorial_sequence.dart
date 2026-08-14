import 'package:flutter_math_app/features/tutorial/domain/entities/tutorial_step_entity.dart';
import 'package:flutter_math_app/features/tutorial/domain/enums/tutorial_step_type.dart';

class TutorialSequence {
  static const List<TutorialStepEntity> steps = [
    TutorialStepEntity(type: TutorialStepType.welcome),
    TutorialStepEntity(type: TutorialStepType.showingPencil),
    TutorialStepEntity(type: TutorialStepType.practiceDraw, expectedResult: 8),
    TutorialStepEntity(type: TutorialStepType.practiceAdd, expectedResult: 5),
    //TutorialStepEntity(type: TutorialStepType.showScoreExplain),
    TutorialStepEntity(type: TutorialStepType.ready),
  ];
}
