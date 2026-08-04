import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/features/game/score/domain/services/score_calculator.dart';

part 'score_state.dart';

class ScoreCubit extends Cubit<ScoreState> {
  DateTime? _questionStartedAt;
  double _currentQuestionWeight = 1.0;

  ScoreCubit() : super(ScoreState());

  void startScore() {
    emit(state.copyWith(currentScore: 0));
  }

  void onQuestionShown({required double weight}) {
    _questionStartedAt = DateTime.now();
    _currentQuestionWeight = weight;
  }

  void onCorrectAnswer() {
    final elapsed = DateTime.now().difference(_questionStartedAt ?? DateTime.now());
    final points = state.currentScore == 0
        ? ScoreCalculator.calculate(elapsed: Duration.zero, referenceTime: const Duration(seconds: 10), questionWeight: _currentQuestionWeight)
        : ScoreCalculator.calculate(elapsed: elapsed, referenceTime: const Duration(seconds: 10), questionWeight: _currentQuestionWeight);

    final newScore = state.currentScore + points;
    emit(state.copyWith(currentScore: newScore, scoreToAdd: points));
  }
}
