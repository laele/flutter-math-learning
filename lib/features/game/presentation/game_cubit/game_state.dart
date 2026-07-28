part of 'game_cubit.dart';

class GameState extends Equatable {
  final GameSessionEntity gameSession;
  final GameQuestionEvent? gameQuestionEvent;
  final GameDialogMessageEvent? gameDialogMessage;
  final bool showScore;
  final Map<GameMode, GameStatsEntity> stats;
  final GamePhaseEvent? gamePhaseEvent;

  final List<GameMode> selectedGameModes;

  final int currentExercise;
  final bool canDraw;

  const GameState({
    required this.selectedGameModes,
    required this.currentExercise,
    this.gamePhaseEvent,
    this.gameDialogMessage,
    this.gameQuestionEvent,
    this.showScore = false,
    this.stats = const {},
    this.gameSession = const GameSessionEntity(),
    this.canDraw = false,
  });

  GameStatsEntity get currentGameStats => stats[gameQuestionEvent!.gameMode] ?? GameStatsEntity();
  GameStatsEntity gameStats(GameMode gameMode) => stats[gameMode] ?? GameStatsEntity();

  GameState copyWith({
    bool? isReady,
    GameQuestionEvent? gameQuestionEvent,
    GamePhaseEvent? gamePhaseEvent,
    GameDialogMessageEvent? gameDialogMessage,
    GameSessionEntity? gameSession,
    Map<GameMode, GameStatsEntity>? stats,
    List<GameMode>? selectedGameModes,
    bool? canDraw,
    bool? showScore,
    int? currentExercise,
  }) {
    return GameState(
      gamePhaseEvent: gamePhaseEvent ?? this.gamePhaseEvent,
      gameDialogMessage: gameDialogMessage ?? this.gameDialogMessage,
      showScore: showScore ?? this.showScore,
      gameSession: gameSession ?? this.gameSession,
      selectedGameModes: selectedGameModes ?? this.selectedGameModes,
      stats: stats ?? this.stats,
      canDraw: canDraw ?? this.canDraw,
      currentExercise: currentExercise ?? this.currentExercise,
      gameQuestionEvent: gameQuestionEvent ?? this.gameQuestionEvent,
    );
  }

  @override
  List<Object?> get props => [
    gamePhaseEvent,
    gameDialogMessage,
    gameQuestionEvent,
    stats,
    canDraw,
    selectedGameModes,
    currentExercise,
    gameSession,
    showScore,
  ];
}
