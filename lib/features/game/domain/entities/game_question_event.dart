import 'package:flutter_math_app/core/entities/domain_event.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_question_entity.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_mode.dart';

class GameQuestionEvent extends DomainEvent {
  final GameQuestionEntity gameQuestion;
  final GameMode gameMode;

  final double questionWeight;

  String get currentGameModeOperator => switch (gameMode) {
    GameMode.add => '+',
    GameMode.sub => '-',
    GameMode.mult => '×',
    GameMode.div => '÷',
    _ => '',
  };

  String get resultExplained => '${gameQuestion.firstNum} $currentGameModeOperator ${gameQuestion.secNum} = ${gameQuestion.resultNum}';
  String get operationMessage => '${gameQuestion.firstNum} $currentGameModeOperator ${gameQuestion.secNum} ';

  const GameQuestionEvent({
    required super.id,
    required this.questionWeight,
    required this.gameQuestion,
    required this.gameMode,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    gameQuestion,
    gameMode,
    questionWeight,
  ];
}
