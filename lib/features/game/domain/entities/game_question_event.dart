import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_question_entity.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_mode.dart';

class GameQuestionEvent extends Equatable {
  final int id;
  final GameQuestionEntity gameQuestion;
  final GameMode gameMode;
  final String indicationMessage;
  final String explanationMessage;

  const GameQuestionEvent({
    required this.id,
    required this.gameQuestion,
    required this.gameMode,
    required this.indicationMessage,
    required this.explanationMessage,
  });

  @override
  List<Object?> get props => [
    id,
    gameQuestion,
    gameMode,
    indicationMessage,
    explanationMessage,
  ];
}
