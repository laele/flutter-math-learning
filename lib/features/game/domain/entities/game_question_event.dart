import 'package:flutter_math_app/core/entities/domain_event.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_question_entity.dart';
import 'package:flutter_math_app/features/game/domain/enums/operation_type.dart';

class GameQuestionEvent extends DomainEvent {
  final GameQuestionEntity gameQuestion;
  final OperationType operationType;

  final double questionWeight;

  String get currentoperationTypeOperator => switch (operationType) {
    OperationType.add => '+',
    OperationType.sub => '-',
    OperationType.mult => '×',
    OperationType.div => '÷',
    _ => '',
  };

  String get resultExplained =>
      '${gameQuestion.firstNum} $currentoperationTypeOperator ${gameQuestion.secNum} = ${gameQuestion.resultNum}';
  String get operationMessage =>
      '${gameQuestion.firstNum} $currentoperationTypeOperator ${gameQuestion.secNum} ';

  const GameQuestionEvent({
    required super.id,
    required this.questionWeight,
    required this.gameQuestion,
    required this.operationType,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    gameQuestion,
    operationType,
    questionWeight,
  ];
}
