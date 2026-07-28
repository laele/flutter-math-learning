import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/core/constants/app_game.dart';
import 'package:flutter_math_app/features/game/domain/constants/difficulty_tiers.dart';
import 'package:flutter_math_app/features/game/domain/constants/game_modes.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_dialog_message_event.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_question_entity.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_question_event.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_session_entity.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_stats_entity.dart';
import 'package:flutter_math_app/features/game/domain/enums/game_mode.dart';
import 'package:flutter_math_app/features/game/domain/services/mix_mode_selector.dart';
import 'package:flutter_math_app/features/game/domain/services/question_generator_factory.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final MixModeSelector _mixModeSelector;
  int _gameQuestionEventCounter = 0;
  int _gamedialogMessageEventCounter = 0;

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

  GameDialogMessageEvent _nextDialogMessageEvent({
    required String message,
    String? upperMessage,
  }) {
    return GameDialogMessageEvent(
      id: ++_gamedialogMessageEventCounter,
      message: message,
      upperMessage: upperMessage,
    );
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
    showInstructionMessage();
  }

  void showInstructionMessage() {
    emit(
      state.copyWith(
        canDraw: true,
        gameDialogMessage: _nextDialogMessageEvent(
          message: state.gameQuestionEvent!.indicationMessage,
          upperMessage: '${state.gameQuestionEvent!.gameQuestion.firstNum} ${state.currentGameModeOperator} ${state.gameQuestionEvent!.gameQuestion.secNum}',
        ),
      ),
    );
  }

  void showIncorrectMessage() {
    emit(
      state.copyWith(
        canDraw: false,
        gameDialogMessage: _nextDialogMessageEvent(
          message: 'Nope! Try it again!',
        ),
      ),
    );
  }

  void showCorrectMessage() {
    emit(
      state.copyWith(
        canDraw: false,
        gameDialogMessage: _nextDialogMessageEvent(
          message: 'Amazing, Let\'s try next number!',
        ),
      ),
    );
  }

  void showExplanationMessage() {
    emit(
      state.copyWith(
        canDraw: false,
        gameDialogMessage: _nextDialogMessageEvent(
          message: '${state.gameQuestionEvent!.explanationMessage}',
        ),
      ),
    );
  }

  void checkResult(int result) async {
    emit(state.copyWith(canDraw: false));
    final wasCorrect = (result == state.gameQuestionEvent!.gameQuestion.resultNum);

    final updatedGameSession = state.gameSession.recordAttempt(wasCorrect: wasCorrect);
    emit(state.copyWith(gameSession: updatedGameSession));

    if (!wasCorrect && state.gameSession.incorrectStreak < AppGame.maxIncorectStreak) {
      showIncorrectMessage();
      await Future.delayed(Duration(seconds: 3));
      showInstructionMessage();
      return;
    }

    final gameMode = state.gameQuestionEvent!.gameMode;
    final tiers = DifficultyTiers.byMode[gameMode];
    var newStats = state.currentGameStats.recordAttempt(wasCorrect);
    var continueNextLevel = true;
    if (!wasCorrect) {
      // Incorrect Attempt
      final isLevelDown = !wasCorrect && tiers != null && newStats.shouldLevelDown && newStats.currentTierIndex > 0;
      if (isLevelDown) {
        newStats = newStats.copyWith(currentTierIndex: newStats.currentTierIndex - 1).resetRegistry();
      } else {
        showExplanationMessage();
      }
    } else {
      // correct Attempt
      final isLevelUp = wasCorrect && tiers != null && newStats.shouldLevelUp && newStats.currentTierIndex < tiers.length - 1;
      if (isLevelUp) {
        newStats = newStats.copyWith(currentTierIndex: newStats.currentTierIndex + 1).resetRegistry();
      }

      if (state.gameSession.isCompleted) {
        continueNextLevel = false;
        emit(state.copyWith(showScore: true, canDraw: false, gameDialogMessage: _nextDialogMessageEvent(message: 'That was fun! Wanna play again?...!')));
      } else {
        showCorrectMessage();
      }
    }

    final cleanIncorrectStreak = state.gameSession.cleanIncorrectStreak();
    emit(state.copyWith(gameSession: cleanIncorrectStreak));
    _setNewStats(gameMode!, newStats);
    await Future.delayed(Duration(seconds: 3));
    if (continueNextLevel) generateNextLevel();
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
