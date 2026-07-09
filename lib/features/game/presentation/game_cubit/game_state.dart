part of 'game_cubit.dart';

enum PetAnimation { idle, thinking, failed, success }

enum GameMode { learnNumbers, learnLetters, add, sub, mult, div, mix }

class GameState extends Equatable {
  final PetAnimation petAnimation;
  final GameMode gameMode;
  final String? message;
  final int? firstNum;
  final int? secNum;
  final int? result;
  final String? letter;
  const GameState({
    required this.petAnimation,
    required this.gameMode,
    this.message,
    this.result,
    this.firstNum,
    this.secNum,
    this.letter,
  });

  GameState copyWith({
    PetAnimation? petAnimation,
    GameMode? gameMode,
    String? message,
    int? result,
    int? firstNum,
    int? secNum,
    String? letter,
  }) {
    return GameState(
      petAnimation: petAnimation ?? this.petAnimation,
      gameMode: gameMode ?? this.gameMode,
      message: message,
      result: result ?? this.result,
      firstNum: firstNum ?? this.firstNum,
      secNum: secNum ?? this.secNum,
      letter: letter ?? this.letter,
    );
  }

  @override
  List<Object?> get props => [
    petAnimation,
    gameMode,
    message,
    result,
    firstNum,
    secNum,
    letter,
  ];
}
