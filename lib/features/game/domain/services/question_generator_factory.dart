import 'package:flutter_math_app/features/game/domain/enums/operation_type.dart';
import 'package:flutter_math_app/features/game/domain/services/question_generator.dart';

class QuestionGeneratorFactory {
  static QuestionGenerator forMode(OperationType mode) {
    return switch (mode) {
      //OperationType.learnNumbers => LearnNumbersQuestionGenerator(),
      OperationType.add => AddQuestionGenerator(),
      OperationType.sub => SubQuestionGenerator(),
      OperationType.mult => MultQuestionGenerator(),
      OperationType.div => DivQuestionGenerator(),
    };
  }
}
