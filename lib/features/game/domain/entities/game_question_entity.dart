import 'package:equatable/equatable.dart';

class GameQuestionEntity extends Equatable {
  final int? firstNum;
  final int? secNum;
  final int? resultNum;
  final int? scoreToAdd;

  const GameQuestionEntity({
    this.firstNum,
    this.secNum,
    this.resultNum,
    this.scoreToAdd,
  });

  @override
  List<Object?> get props => [
    firstNum,
    secNum,
    resultNum,
    scoreToAdd,
  ];
}
