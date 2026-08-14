import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/features/tutorial/domain/enums/tutorial_step_type.dart';

class TutorialStepEntity extends Equatable {
  final TutorialStepType type;
  final int? expectedResult;
  final bool requiresInput;

  const TutorialStepEntity({required this.type, this.expectedResult, required this.requiresInput});

  @override
  List<Object?> get props => [
    type,
    expectedResult,
    requiresInput,
  ];
}
