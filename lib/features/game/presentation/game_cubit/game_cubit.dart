import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/core/mixins/event_emitter.dart';
import 'package:flutter_math_app/core/mixins/pausable_actions.dart';
import 'package:flutter_math_app/core/usecase/usecase.dart';
import 'package:flutter_math_app/features/game/domain/constants/difficulty_tiers.dart';
import 'package:flutter_math_app/features/game/domain/constants/game_modes.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_phase_event.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_question_entity.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_question_event.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_session_entity.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_stats_entity.dart';
import 'package:flutter_math_app/features/game/domain/enums/operation_type.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_phase.dart';
import 'package:flutter_math_app/features/game/domain/services/game_rules_policy.dart';
import 'package:flutter_math_app/features/game/domain/services/mix_mode_selector.dart';
import 'package:flutter_math_app/features/game/domain/services/question_generator_factory.dart';
import 'package:flutter_math_app/features/game/domain/services/question_weight_calculator.dart';
import 'package:flutter_math_app/features/game/domain/usecases/get_game_stats_usecase.dart';
import 'package:flutter_math_app/features/game/domain/usecases/save_game_stats_usecase.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> with EventEmitter, PausableActions {
  final MixModeSelector _mixModeSelector;
  final GameRulesPolicy _gameRulesPolicy;

  final GetGameStatsUseCase _getGameStatsUseCase;
  final SaveGameStatsUseCase _saveGameStatsUseCase;

  GameCubit({
    MixModeSelector? mixModeSelector,
    required GameRulesPolicy rulesPolicy,
    required GetGameStatsUseCase getGameStatsUseCase,
    required SaveGameStatsUseCase saveGameStatsUseCase,
  }) : _mixModeSelector = mixModeSelector ?? MixModeSelector(),
       _getGameStatsUseCase = getGameStatsUseCase,
       _saveGameStatsUseCase = saveGameStatsUseCase,
       _gameRulesPolicy = rulesPolicy,
       super(
         GameState(
           selectedoperationTypes: operationTypes.items
               .map((e) => e.operationType)
               .toList(),
         ),
       );

  GameQuestionEvent _nextGameQuestionEvent({
    required GameQuestionEntity gameQuestion,
    required OperationType operationType,
    required double questionWeight,
  }) {
    return GameQuestionEvent(
      id: nextEventId(),
      gameQuestion: gameQuestion,
      operationType: operationType,
      questionWeight: questionWeight,
    );
  }

  void _emitNextGamePhaseEvent({required GamePhase gamePhase}) {
    final gamePhaseEvent = GamePhaseEvent(
      id: nextEventId(),
      gamePhase: gamePhase,
    );
    emit(state.copyWith(gamePhaseEvent: gamePhaseEvent));
  }

  void initGame() async {
    Map<OperationType, GameStatsEntity> stats;

    if (_gameRulesPolicy.useStats) {
      final statsResult = await _getGameStatsUseCase(NoParams());
      final loadedStats = statsResult.fold(
        (l) => <OperationType, GameStatsEntity>{},
        (stats) {
          return stats;
        },
      );
      stats = loadedStats;
    } else {
      stats = {};
    }

    emit(state.copyWith(gameSession: GameSessionEntity(), stats: stats));
    _emitNextGamePhaseEvent(gamePhase: GamePhase.starting);
    pauseFor(() {
      generateNextLevel();
    });
  }

  void generateNextLevel() {
    final nextoperationType = _mixModeSelector.pickNext(
      candidates: state.selectedoperationTypes,
      stats: state.stats,
    );
    final tiers = DifficultyTiers.byMode[nextoperationType];
    if (tiers == null) return;

    final currentGameStats = state.gameStats(nextoperationType);

    final currentTier = tiers[currentGameStats.currentTierIndex];
    final generator = QuestionGeneratorFactory.forMode(nextoperationType);
    final questionWeight = QuestionWeightCalculator.calculate(
      operationType: nextoperationType,
      tier: currentTier,
    );
    final question = generator.generate(currentTier);

    emit(
      state.copyWith(
        gameQuestionEvent: _nextGameQuestionEvent(
          questionWeight: questionWeight,
          gameQuestion: question,
          operationType: nextoperationType,
        ),
      ),
    );
    _emitNextGamePhaseEvent(gamePhase: GamePhase.newQuestion);
  }

  void checkResult({required int result}) async {
    _emitNextGamePhaseEvent(gamePhase: GamePhase.checkingResult);
    final wasCorrect =
        (result == state.gameQuestionEvent!.gameQuestion.resultNum);

    final updatedGameSession = state.gameSession.recordAttempt(
      wasCorrect: wasCorrect,
    );
    emit(state.copyWith(gameSession: updatedGameSession));

    if (wasCorrect) {
      _handleCorrect();
    } else {
      _handleIncorrect(session: updatedGameSession);
    }
  }

  void _handleCorrect() {
    final operationType = state.gameQuestionEvent!.operationType;
    var newStats = state.currentGameStats.recordAttempt(true);
    final tiers = DifficultyTiers.byMode[operationType];

    final cleanedSession = state.gameSession.cleanIncorrectStreak();
    emit(state.copyWith(gameSession: cleanedSession));

    final isLevelUp =
        _gameRulesPolicy.allowLevelUp &&
        tiers != null &&
        newStats.shouldLevelUp &&
        newStats.currentTierIndex < tiers.length - 1;
    if (isLevelUp) {
      newStats = newStats
          .copyWith(currentTierIndex: newStats.currentTierIndex + 1)
          .resetRegistry();
    }
    _setNewStats(operationType, newStats);
    _emitNextGamePhaseEvent(gamePhase: GamePhase.correct);
    pauseFor(
      () => _continueAfterAttempt(),
    );
  }

  void _handleIncorrect({required GameSessionEntity session}) {
    final maxAttempts = _gameRulesPolicy.maxIncorrectAttemptsToSkip;
    if (maxAttempts == null || session.incorrectStreak < maxAttempts) {
      _emitNextGamePhaseEvent(gamePhase: GamePhase.incorrect);
      pauseFor(
        () => _emitNextGamePhaseEvent(gamePhase: GamePhase.repeatQuestion),
      );
      return;
    }

    final operationType = state.gameQuestionEvent!.operationType;
    var newStats = state.currentGameStats.recordAttempt(false);
    final tiers = DifficultyTiers.byMode[operationType];

    if (_gameRulesPolicy.allowLevelDown &&
        tiers != null &&
        newStats.shouldLevelDown &&
        newStats.currentTierIndex > 0) {
      newStats = newStats
          .copyWith(currentTierIndex: newStats.currentTierIndex - 1)
          .resetRegistry();
    }

    _setNewStats(operationType, newStats);
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
      // save stats
      final currentStats = state.stats;
      _saveGameStatsUseCase(currentStats);

      _emitNextGamePhaseEvent(gamePhase: GamePhase.finished);
    } else {
      generateNextLevel();
    }
  }

  Future<void> setErrorGamePhase() async {
    _emitNextGamePhaseEvent(gamePhase: GamePhase.error);
    pauseFor(
      () => _emitNextGamePhaseEvent(gamePhase: GamePhase.repeatQuestion),
    );
  }

  Future<void> setFinishedGamePhase() async {
    _emitNextGamePhaseEvent(gamePhase: GamePhase.finished);
  }

  void _setNewStats(OperationType mode, GameStatsEntity newStats) {
    final stats = Map<OperationType, GameStatsEntity>.from(state.stats)
      ..[mode] = newStats;
    emit(state.copyWith(stats: stats));
  }
}
