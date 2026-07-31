import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/core/constants/app_game.dart';
import 'package:flutter_math_app/features/game/domain/constants/difficulty_tiers.dart';
import 'package:flutter_math_app/features/game/domain/constants/game_modes.dart';
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

  VoidCallback? _nextAction;

  GameCubit({MixModeSelector? mixModeSelector})
    : _mixModeSelector = mixModeSelector ?? MixModeSelector(),
      super(
        GameState(
          selectedGameModes: GameModes.items.map((e) => e.gameMode).toList(),
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

  void _emitNextGamePhaseEvent({required GamePhase gamePhase}) {
    final gamePhaseEvent = GamePhaseEvent(id: ++_gamePhaseEventCounter, gamePhase: gamePhase);
    emit(state.copyWith(gamePhaseEvent: gamePhaseEvent));
  }

  void _pause(GamePhase phase, VoidCallback nextAction) {
    _emitNextGamePhaseEvent(gamePhase: phase);
    _nextAction = nextAction;
  }

  void continueAction() {
    final action = _nextAction;
    _nextAction = null;
    action?.call();
  }

  void initGame() {
    emit(state.copyWith(gameSession: GameSessionEntity()));
    _emitNextGamePhaseEvent(gamePhase: GamePhase.starting);
    generateNextLevel();
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
    _emitNextGamePhaseEvent(gamePhase: GamePhase.newQuestion);
  }

  void checkResult(int result) async {
    _emitNextGamePhaseEvent(gamePhase: GamePhase.checkingResult);
    final wasCorrect = (result == state.gameQuestionEvent!.gameQuestion.resultNum);

    final updatedGameSession = state.gameSession.recordAttempt(wasCorrect: wasCorrect);
    emit(state.copyWith(gameSession: updatedGameSession));

    if (!wasCorrect) {
      _pause(GamePhase.incorrect, () {
        _emitNextGamePhaseEvent(gamePhase: GamePhase.repeatQuestion);
      });
      return;
    }

    final gameMode = state.gameQuestionEvent!.gameMode;
    final tiers = DifficultyTiers.byMode[gameMode];
    var newStats = state.currentGameStats.recordAttempt(wasCorrect);

    final isLevelUp = wasCorrect && tiers != null && newStats.shouldLevelUp && newStats.currentTierIndex < tiers.length - 1;
    if (isLevelUp) {
      newStats = newStats.copyWith(currentTierIndex: newStats.currentTierIndex + 1).resetRegistry();
    }
    _setNewStats(gameMode, newStats);
    _pause(GamePhase.correct, _continueAfterAttempt);

    /*if (!wasCorrect) {
      // Incorrect Attempt
      /*final isLevelDown = !wasCorrect && tiers != null && newStats.shouldLevelDown && newStats.currentTierIndex > 0;
      if (isLevelDown) {
        newStats = newStats.copyWith(currentTierIndex: newStats.currentTierIndex - 1).resetRegistry();
      }*/
      //_setNewStats(gameMode, newStats);
      _pause(GamePhase.skipByIncorrect, () {
        _pause(GamePhase.explanation, _continueAfterAttempt);
      });
    } else {
      // correct Attempt
      final isLevelUp = wasCorrect && tiers != null && newStats.shouldLevelUp && newStats.currentTierIndex < tiers.length - 1;
      if (isLevelUp) {
        newStats = newStats.copyWith(currentTierIndex: newStats.currentTierIndex + 1).resetRegistry();
      }
      _setNewStats(gameMode, newStats);
      _pause(GamePhase.correct, _continueAfterAttempt);
    }*/
  }

  /*void checkResult(int result) async {
    _emitNextGamePhaseEvent(gamePhase: GamePhase.checkingResult);
    final wasCorrect = (result == state.gameQuestionEvent!.gameQuestion.resultNum);

    final updatedGameSession = state.gameSession.recordAttempt(wasCorrect: wasCorrect);
    emit(state.copyWith(gameSession: updatedGameSession));

    if (!wasCorrect && state.gameSession.incorrectStreak < AppGame.maxIncorectStreak) {
      _pause(GamePhase.incorrect, () {
        _emitNextGamePhaseEvent(gamePhase: GamePhase.question);
      });
      return;
    }

    final gameMode = state.gameQuestionEvent!.gameMode;
    final tiers = DifficultyTiers.byMode[gameMode];
    var newStats = state.currentGameStats.recordAttempt(wasCorrect);

    if (!wasCorrect) {
      // Incorrect Attempt
      final isLevelDown = !wasCorrect && tiers != null && newStats.shouldLevelDown && newStats.currentTierIndex > 0;
      if (isLevelDown) {
        newStats = newStats.copyWith(currentTierIndex: newStats.currentTierIndex - 1).resetRegistry();
      }
      _setNewStats(gameMode, newStats);
      _pause(GamePhase.skipByIncorrect, () {
        _pause(GamePhase.explanation, _continueAfterAttempt);
      });
    } else {
      // correct Attempt
      final isLevelUp = wasCorrect && tiers != null && newStats.shouldLevelUp && newStats.currentTierIndex < tiers.length - 1;
      if (isLevelUp) {
        newStats = newStats.copyWith(currentTierIndex: newStats.currentTierIndex + 1).resetRegistry();
      }
      _setNewStats(gameMode, newStats);
      _pause(GamePhase.correct, _continueAfterAttempt);
    }
  }*/

  void _continueAfterAttempt() {
    emit(state.copyWith(gameSession: state.gameSession.cleanIncorrectStreak()));
    generateNextLevel();
    /*if (state.gameSession.isCompleted) {
      _emitNextGamePhaseEvent(gamePhase: GamePhase.finished);
    } else {
      generateNextLevel();
    }*/
  }

  Future<void> setErrorGamePhase() async {
    _pause(GamePhase.error, () {
      _emitNextGamePhaseEvent(gamePhase: GamePhase.repeatQuestion);
    });
  }

  Future<void> setFinishedGamePhase() async {
    _emitNextGamePhaseEvent(gamePhase: GamePhase.finished);
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
