part of 'game_cubit.dart';

class GameState extends Equatable {
  final GameSessionEntity gameSession;
  final GameQuestionEvent? gameQuestionEvent;
  final GamePhaseEvent? gamePhaseEvent;
  final Map<GameMode, GameStatsEntity> stats;
  final List<GameMode> selectedGameModes;

  const GameState({
    required this.selectedGameModes,
    this.gameSession = const GameSessionEntity(),
    this.stats = const {},
    this.gamePhaseEvent,
    this.gameQuestionEvent,
  });

  GameStatsEntity get currentGameStats => stats[gameQuestionEvent!.gameMode] ?? GameStatsEntity();
  GameStatsEntity gameStats(GameMode gameMode) => stats[gameMode] ?? GameStatsEntity();

  GameState copyWith({
    GameQuestionEvent? gameQuestionEvent,
    GamePhaseEvent? gamePhaseEvent,
    GameSessionEntity? gameSession,
    Map<GameMode, GameStatsEntity>? stats,
    List<GameMode>? selectedGameModes,
  }) {
    return GameState(
      gamePhaseEvent: gamePhaseEvent ?? this.gamePhaseEvent,
      gameSession: gameSession ?? this.gameSession,
      selectedGameModes: selectedGameModes ?? this.selectedGameModes,
      stats: stats ?? this.stats,
      gameQuestionEvent: gameQuestionEvent ?? this.gameQuestionEvent,
    );
  }

  @override
  List<Object?> get props => [
    gamePhaseEvent,
    gameQuestionEvent,
    gameSession,
    stats,
    selectedGameModes,
  ];
}
