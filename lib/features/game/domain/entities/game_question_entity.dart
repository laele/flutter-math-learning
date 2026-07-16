import 'package:equatable/equatable.dart';

class GameQuestionEntity extends Equatable {
  final int? firstNum;
  final int? secNum;
  final int? resultNum;

  const GameQuestionEntity({
    this.firstNum,
    this.secNum,
    this.resultNum,
  });

  @override
  List<Object?> get props => [
    firstNum,
    secNum,
    resultNum,
  ];
}
