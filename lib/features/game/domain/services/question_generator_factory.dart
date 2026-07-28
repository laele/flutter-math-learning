import 'package:flutter_math_app/features/game/domain/enums/game_mode.dart';
import 'package:flutter_math_app/features/game/domain/services/question_generator.dart';

class QuestionGeneratorFactory {
  static QuestionGenerator forMode(GameMode mode) {
    return switch (mode) {
      //GameMode.learnNumbers => LearnNumbersQuestionGenerator(),
      GameMode.add => AddQuestionGenerator(),
      GameMode.sub => SubQuestionGenerator(),
      GameMode.mult => MultQuestionGenerator(),
      GameMode.div => DivQuestionGenerator(),
    };
  }
}
