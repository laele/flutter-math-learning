part of 'game_cubit.dart';

class GameState extends Equatable {
  final GameSessionEntity gameSession;
  final GameQuestionEvent? gameQuestionEvent;
  final GamePhaseEvent? gamePhaseEvent;
  final Map<OperationType, GameStatsEntity> stats;
  final List<OperationType> selectedoperationTypes;

  const GameState({
    required this.selectedoperationTypes,
    this.gameSession = const GameSessionEntity(),
    this.stats = const {},
    this.gamePhaseEvent,
    this.gameQuestionEvent,
  });

  GameStatsEntity get currentGameStats =>
      stats[gameQuestionEvent!.operationType] ?? GameStatsEntity();
  GameStatsEntity gameStats(OperationType operationType) =>
      stats[operationType] ?? GameStatsEntity();

  GameState copyWith({
    GameQuestionEvent? gameQuestionEvent,
    GamePhaseEvent? gamePhaseEvent,
    GameSessionEntity? gameSession,
    Map<OperationType, GameStatsEntity>? stats,
    List<OperationType>? selectedoperationTypes,
  }) {
    return GameState(
      gamePhaseEvent: gamePhaseEvent ?? this.gamePhaseEvent,
      gameSession: gameSession ?? this.gameSession,
      selectedoperationTypes:
          selectedoperationTypes ?? this.selectedoperationTypes,
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
    selectedoperationTypes,
  ];
}
