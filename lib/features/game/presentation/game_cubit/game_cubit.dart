import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/core/mixins/event_emitter.dart';
import 'package:flutter_math_app/core/mixins/pausable_actions.dart';
import 'package:flutter_math_app/features/game/domain/constants/difficulty_tiers.dart';
import 'package:flutter_math_app/features/game/domain/constants/game_modes.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_phase_event.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_question_entity.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_question_event.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_session_entity.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_stats_entity.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_mode.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_phase.dart';
import 'package:flutter_math_app/features/game/domain/services/game_rules_policy.dart';
import 'package:flutter_math_app/features/game/domain/services/mix_mode_selector.dart';
import 'package:flutter_math_app/features/game/domain/services/question_generator_factory.dart';
import 'package:flutter_math_app/features/game/domain/services/question_weight_calculator.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> with EventEmitter, PausableActions {
  final MixModeSelector _mixModeSelector;
  final GameRulesPolicy _gameRulesPolicy;

  GameCubit({
    MixModeSelector? mixModeSelector,
    required GameRulesPolicy rulesPolicy,
  }) : _mixModeSelector = mixModeSelector ?? MixModeSelector(),
       _gameRulesPolicy = rulesPolicy,
       super(
         GameState(
           selectedGameModes: GameModes.items.map((e) => e.gameMode).toList(),
         ),
       );

  GameQuestionEvent _nextGameQuestionEvent({
    required GameQuestionEntity gameQuestion,
    required GameMode gameMode,
    required double questionWeight,
  }) {
    return GameQuestionEvent(
      id: nextEventId(),
      gameQuestion: gameQuestion,
      gameMode: gameMode,
      questionWeight: questionWeight,
    );
  }

  void _emitNextGamePhaseEvent({required GamePhase gamePhase}) {
    final gamePhaseEvent = GamePhaseEvent(id: nextEventId(), gamePhase: gamePhase);
    emit(state.copyWith(gamePhaseEvent: gamePhaseEvent));
  }

  void initGame() {
    emit(state.copyWith(gameSession: GameSessionEntity(), stats: {})); // Cambiar pot stats del profile player
    _emitNextGamePhaseEvent(gamePhase: GamePhase.starting);
    pauseFor(
      () {
        generateNextLevel();
      },
    );
  }

  void generateNextLevel() {
    final nextGameMode = _mixModeSelector.pickNext(
      candidates: state.selectedGameModes,
      stats: state.stats,
    );
    final tiers = DifficultyTiers.byMode[nextGameMode];
    if (tiers == null) return;

    final currentGameStats = state.gameStats(nextGameMode);

    final currentTier = tiers[currentGameStats.currentTierIndex];
    final generator = QuestionGeneratorFactory.forMode(nextGameMode);
    final questionWeight = QuestionWeightCalculator.calculate(gameMode: nextGameMode, tier: currentTier);
    final question = generator.generate(currentTier);

    emit(
      state.copyWith(
        gameQuestionEvent: _nextGameQuestionEvent(
          questionWeight: questionWeight,
          gameQuestion: question,
          gameMode: nextGameMode,
        ),
      ),
    );
    _emitNextGamePhaseEvent(gamePhase: GamePhase.newQuestion);
  }

  void checkResult({required int result}) async {
    _emitNextGamePhaseEvent(gamePhase: GamePhase.checkingResult);
    final wasCorrect = (result == state.gameQuestionEvent!.gameQuestion.resultNum);

    final updatedGameSession = state.gameSession.recordAttempt(wasCorrect: wasCorrect);
    emit(state.copyWith(gameSession: updatedGameSession));

    if (wasCorrect) {
      _handleCorrect();
    } else {
      _handleIncorrect(session: updatedGameSession);
    }
  }

  void _handleCorrect() {
    final gameMode = state.gameQuestionEvent!.gameMode;
    var newStats = state.currentGameStats.recordAttempt(true);
    final tiers = DifficultyTiers.byMode[gameMode];

    final cleanedSession = state.gameSession.cleanIncorrectStreak();
    emit(state.copyWith(gameSession: cleanedSession));

    final isLevelUp = _gameRulesPolicy.allowLevelUp && tiers != null && newStats.shouldLevelUp && newStats.currentTierIndex < tiers.length - 1;
    if (isLevelUp) {
      newStats = newStats.copyWith(currentTierIndex: newStats.currentTierIndex + 1).resetRegistry();
    }
    _setNewStats(gameMode, newStats);
    _emitNextGamePhaseEvent(gamePhase: GamePhase.correct);
    pauseFor(
      () => _continueAfterAttempt(),
    );
  }

  void _handleIncorrect({required GameSessionEntity session}) {
    final maxAttempts = _gameRulesPolicy.maxIncorrectAttemptsToSkip;
    if (maxAttempts == null || session.incorrectStreak < maxAttempts) {
      _emitNextGamePhaseEvent(gamePhase: GamePhase.incorrect);
      pauseFor(() => _emitNextGamePhaseEvent(gamePhase: GamePhase.repeatQuestion));
      return;
    }

    final gameMode = state.gameQuestionEvent!.gameMode;
    var newStats = state.currentGameStats.recordAttempt(false);
    final tiers = DifficultyTiers.byMode[gameMode];

    if (_gameRulesPolicy.allowLevelDown && tiers != null && newStats.shouldLevelDown && newStats.currentTierIndex > 0) {
      newStats = newStats.copyWith(currentTierIndex: newStats.currentTierIndex - 1).resetRegistry();
    }

    _setNewStats(gameMode, newStats);
    _emitNextGamePhaseEvent(gamePhase: GamePhase.skipByIncorrect);
    pauseFor(
      () {
        final cleanedSession = state.gameSession.cleanIncorrectStreak();
        emit(state.copyWith(gameSession: cleanedSession));
        _emitNextGamePhaseEvent(gamePhase: GamePhase.explanation);
        pauseFor(
          () => _continueAfterAttempt(),
        );
      },
    );
  }

  void _continueAfterAttempt() {
    if (_gameRulesPolicy.shouldEndSession(state.gameSession)) {
      _emitNextGamePhaseEvent(gamePhase: GamePhase.finished);
    } else {
      generateNextLevel();
    }
  }

  Future<void> setErrorGamePhase() async {
    _emitNextGamePhaseEvent(gamePhase: GamePhase.error);
    pauseFor(() => _emitNextGamePhaseEvent(gamePhase: GamePhase.repeatQuestion));
  }

  Future<void> setFinishedGamePhase() async {
    _emitNextGamePhaseEvent(gamePhase: GamePhase.finished);
  }

  void _setNewStats(GameMode mode, GameStatsEntity newStats) {
    final stats = Map<GameMode, GameStatsEntity>.from(state.stats)..[mode] = newStats;
    emit(state.copyWith(stats: stats));
  }
}
