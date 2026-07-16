import 'package:equatable/equatable.dart';

class GameStatsEntity extends Equatable {
  static const maxRegistrySize = 5;
  static const correctAttemptsToLevelUp = 4;
  static const correctAttemptsToLevelDown = 1;

  final List<bool> recentResults;
  final int currentTierIndex;
  final int attempts;
  final int correctCount;

  const GameStatsEntity({
    this.recentResults = const [],
    this.currentTierIndex = 0,
    this.attempts = 0,
    this.correctCount = 0,
  });

  GameStatsEntity recordAttempt(bool wasCorrect) {
    final updatedResults = [...recentResults, wasCorrect];
    final newResults = updatedResults.length > maxRegistrySize ? updatedResults.sublist(updatedResults.length - maxRegistrySize) : updatedResults;

    return copyWith(recentResults: newResults, attempts: attempts + 1, correctCount: correctCount + (wasCorrect ? 1 : 0));
  }

  int get correctInRegistry => recentResults.where((element) => element).length;
  bool get shouldLevelUp => recentResults.length == maxRegistrySize && correctInRegistry >= correctAttemptsToLevelUp;
  bool get shouldLevelDown => recentResults.length == maxRegistrySize && correctInRegistry <= correctAttemptsToLevelDown;

  GameStatsEntity resetRegistry() => copyWith(recentResults: []);

  double get errorRate => attempts == 0 ? 1.0 : 1 - (correctCount / attempts);

  GameStatsEntity copyWith({
    List<bool>? recentResults,
    int? currentTierIndex,
    int? attempts,
    int? correctCount,
  }) {
    return GameStatsEntity(
      recentResults: recentResults ?? this.recentResults,
      currentTierIndex: currentTierIndex ?? this.currentTierIndex,
      attempts: attempts ?? this.attempts,
      correctCount: correctCount ?? this.correctCount,
    );
  }

  @override
  List<Object?> get props => [
    recentResults,
    currentTierIndex,
    correctCount,
    attempts,
  ];
}
