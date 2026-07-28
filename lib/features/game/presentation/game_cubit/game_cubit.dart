import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/core/constants/app_game.dart';
import 'package:flutter_math_app/features/game/domain/constants/difficulty_tiers.dart';
import 'package:flutter_math_app/features/game/domain/constants/game_modes.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_dialog_message_event.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_phase_event.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_question_entity.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_question_event.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_session_entity.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_stats_entity.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_mode.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_phase.dart';
import 'package:flutter_math_app/features/game/domain/services/mix_mode_selector.dart';
import 'package:flutter_math_app/features/game/domain/services/question_generator_factory.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final MixModeSelector _mixModeSelector;
  int _gameQuestionEventCounter = 0;
  int _gamePhaseEventCounter = 0;

  GameCubit({MixModeSelector? mixModeSelector})
    : _mixModeSelector = mixModeSelector ?? MixModeSelector(),
      super(
        GameState(
          selectedGameModes: GameModes.items.map((e) => e.gameMode).toList(),
          currentExercise: 0,
        ),
      );

  GameQuestionEvent _nextGameQuestionEvent({
    required GameQuestionEntity gameQuestion,
    required GameMode gameMode,
    required String indicationMessage,
    required String explanationMessage,
  }) {
    return GameQuestionEvent(
      id: ++_gameQuestionEventCounter,
      gameQuestion: gameQuestion,
      gameMode: gameMode,
      indicationMessage: indicationMessage,
      explanationMessage: explanationMessage,
    );
  }

  Future<void> _emitNextGamePhaseEvent({required GamePhase gamePhase, Duration duration = const Duration(seconds: 3)}) async {
    final gamePhaseEvent = GamePhaseEvent(id: ++_gamePhaseEventCounter, gamePhase: gamePhase);
    emit(state.copyWith(gamePhaseEvent: gamePhaseEvent));
    await Future.delayed(duration);
  }

  void generateNextLevel() async {
    final nextGameMode = _mixModeSelector.pickNext(
      candidates: state.selectedGameModes,
      stats: state.stats,
    );
    final tiers = DifficultyTiers.byMode[nextGameMode];
    if (tiers == null) return;

    final currentGameStats = state.gameStats(nextGameMode);

    final currentTier = tiers[currentGameStats.currentTierIndex];
    final generator = QuestionGeneratorFactory.forMode(nextGameMode);
    final question = generator.generate(currentTier);
    emit(
      state.copyWith(
        gameQuestionEvent: _nextGameQuestionEvent(
          gameQuestion: question,
          gameMode: nextGameMode,
          indicationMessage: _messageFromNewQuestion(gameMode: nextGameMode),
          explanationMessage: _messageExplanationFromQuestion(
            gameMode: nextGameMode,
            gameQuestion: question,
          ),
        ),
      ),
    );
    await _emitNextGamePhaseEvent(gamePhase: GamePhase.question);
  }

  void checkResult(int result) async {
    await _emitNextGamePhaseEvent(gamePhase: GamePhase.checkingResult);
    final wasCorrect = (result == state.gameQuestionEvent!.gameQuestion.resultNum);

    final updatedGameSession = state.gameSession.recordAttempt(wasCorrect: wasCorrect);
    emit(state.copyWith(gameSession: updatedGameSession));

    if (!wasCorrect && state.gameSession.incorrectStreak < AppGame.maxIncorectStreak) {
      await _emitNextGamePhaseEvent(gamePhase: GamePhase.incorrect);
      await _emitNextGamePhaseEvent(gamePhase: GamePhase.question);
      return;
    }

    final gameMode = state.gameQuestionEvent!.gameMode;
    final tiers = DifficultyTiers.byMode[gameMode];
    var newStats = state.currentGameStats.recordAttempt(wasCorrect);
    var continueNextLevel = true;
    if (!wasCorrect) {
      // Incorrect Attempt
      await _emitNextGamePhaseEvent(gamePhase: GamePhase.incorrect);
      final isLevelDown = !wasCorrect && tiers != null && newStats.shouldLevelDown && newStats.currentTierIndex > 0;
      if (isLevelDown) {
        newStats = newStats.copyWith(currentTierIndex: newStats.currentTierIndex - 1).resetRegistry();
      }
      await _emitNextGamePhaseEvent(gamePhase: GamePhase.explanation);
    } else {
      // correct Attempt
      await _emitNextGamePhaseEvent(gamePhase: GamePhase.correct);
      final isLevelUp = wasCorrect && tiers != null && newStats.shouldLevelUp && newStats.currentTierIndex < tiers.length - 1;
      if (isLevelUp) {
        newStats = newStats.copyWith(currentTierIndex: newStats.currentTierIndex + 1).resetRegistry();
      }
      if (state.gameSession.isCompleted) {
        await _emitNextGamePhaseEvent(gamePhase: GamePhase.finished, duration: Duration.zero);
        continueNextLevel = false;
      }
    }

    final cleanIncorrectStreak = state.gameSession.cleanIncorrectStreak();
    emit(state.copyWith(gameSession: cleanIncorrectStreak));
    _setNewStats(gameMode!, newStats);
    if (continueNextLevel) generateNextLevel();
  }

  Future<void> setErrorGamePhase() async {
    await _emitNextGamePhaseEvent(gamePhase: GamePhase.error);
    await _emitNextGamePhaseEvent(gamePhase: GamePhase.question);
  }

  String _messageFromNewQuestion({required GameMode gameMode}) {
    return switch (gameMode) {
      //GameMode.learnNumbers => 'Draw this number!',
      GameMode.add => 'Let\'s add these numbers!',
      GameMode.sub => 'Time to substract!',
      GameMode.mult => 'Let\'s multiply!',
      GameMode.div => 'Can you solve this division?',
      _ => '',
    };
  }

  String _messageExplanationFromQuestion({required GameMode gameMode, required GameQuestionEntity gameQuestion}) {
    return switch (gameMode) {
      //GameMode.learnNumbers => 'Draw this number!',
      GameMode.add => '${gameQuestion.firstNum} + ${gameQuestion.secNum} = ${gameQuestion.resultNum}',
      GameMode.sub => '${gameQuestion.firstNum} - ${gameQuestion.secNum} = ${gameQuestion.resultNum}',
      GameMode.mult => '${gameQuestion.firstNum} × ${gameQuestion.secNum} = ${gameQuestion.resultNum}',
      GameMode.div => '${gameQuestion.firstNum} ÷ ${gameQuestion.secNum} = ${gameQuestion.resultNum}',
      _ => '',
    };
  }

  void _setNewStats(GameMode mode, GameStatsEntity newStats) {
    final stats = Map<GameMode, GameStatsEntity>.from(state.stats)..[mode] = newStats;
    emit(state.copyWith(stats: stats));
  }
}
