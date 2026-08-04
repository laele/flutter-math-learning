part of 'score_cubit.dart';

class ScoreState extends Equatable {
  final int currentScore;
  final int scoreToAdd;

  const ScoreState({
    this.currentScore = 0,
    this.scoreToAdd = 0,
  });

  ScoreState copyWith({
    int? currentScore,
    int? scoreToAdd,
  }) {
    return ScoreState(currentScore: currentScore ?? this.currentScore, scoreToAdd: scoreToAdd ?? this.scoreToAdd);
  }

  @override
  List<Object?> get props => [
    currentScore,
    scoreToAdd,
  ];
}
