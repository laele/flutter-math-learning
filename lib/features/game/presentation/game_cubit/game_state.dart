part of 'game_cubit.dart';

class GameState extends Equatable {
  final GameSessionEntity gameSession;
  final GameQuestionEvent? gameQuestionEvent;
  final GamePhaseEvent? gamePhaseEvent;
  final Map<OperationType, GameStatsEntity> stats;
  final List<OperationType> selectedGameModes;

  const GameState({
    required this.selectedGameModes,
    this.gameSession = const GameSessionEntity(),
    this.stats = const {},
    this.gamePhaseEvent,
    this.gameQuestionEvent,
  });

  GameStatsEntity get currentGameStats => stats[gameQuestionEvent!.gameMode] ?? GameStatsEntity();
  GameStatsEntity gameStats(OperationType gameMode) => stats[gameMode] ?? GameStatsEntity();

  GameState copyWith({
    GameQuestionEvent? gameQuestionEvent,
    GamePhaseEvent? gamePhaseEvent,
    GameSessionEntity? gameSession,
    Map<OperationType, GameStatsEntity>? stats,
    List<OperationType>? selectedGameModes,
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
