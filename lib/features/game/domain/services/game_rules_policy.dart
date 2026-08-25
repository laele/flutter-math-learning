import 'package:flutter_math_app/core/constants/app_game.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_session_entity.dart';

abstract interface class GameRulesPolicy {
  // load and update stats after game session
  bool get useStats;
  bool get allowLevelDown;
  bool get allowLevelUp;

  // if null then repeat question after fail
  int? get maxIncorrectAttemptsToSkip;

  // decide if game session should end after incorrect attempt
  bool shouldEndSession(GameSessionEntity session);
}

class PracticeRulesPolicy implements GameRulesPolicy {
  @override
  int? get maxIncorrectAttemptsToSkip => AppGame.maxIncorectStreak;

  @override
  bool get allowLevelDown => true;

  @override
  bool get allowLevelUp => true;

  @override
  bool shouldEndSession(GameSessionEntity session) {
    return session.isCompleted;
  }

  @override
  bool get useStats => true;
}

class ArcadeRulesPolicy implements GameRulesPolicy {
  @override
  bool get allowLevelDown => false;

  @override
  bool get allowLevelUp => true;

  @override
  int? get maxIncorrectAttemptsToSkip => null;

  @override
  bool shouldEndSession(GameSessionEntity session) {
    return false;
  }

  @override
  bool get useStats => false;
}
