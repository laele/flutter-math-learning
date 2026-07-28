part of 'game_cubit.dart';

class GameState extends Equatable {
  final GameSessionEntity gameSession;
  final GameQuestionEvent? gameQuestionEvent;
  final GameDialogMessageEvent? gameDialogMessage;
  //final String? dialogMessage;
  //final String? upperDialogMesage;
  final bool showScore;
  final Map<GameMode, GameStatsEntity> stats;

  final List<GameMode> selectedGameModes;

  final int currentExercise;
  final bool canDraw;

  const GameState({
    required this.selectedGameModes,
    required this.currentExercise,
    this.gameDialogMessage,
    this.gameQuestionEvent,
    this.showScore = false,
    this.stats = const {},
    this.gameSession = const GameSessionEntity(),
    this.canDraw = false,
  });

  GameStatsEntity get currentGameStats => stats[gameQuestionEvent!.gameMode] ?? GameStatsEntity();
  GameStatsEntity gameStats(GameMode gameMode) => stats[gameMode] ?? GameStatsEntity();
  String get currentGameModeOperator => switch (gameQuestionEvent!.gameMode) {
    GameMode.add => '+',
    GameMode.sub => '-',
    GameMode.mult => '×',
    GameMode.div => '÷',
    _ => '',
  };
  GameState copyWith({
    GameQuestionEvent? gameQuestionEvent,
    bool? showScore,
    GameSessionEntity? gameSession,
    Map<GameMode, GameStatsEntity>? stats,
    List<GameMode>? selectedGameModes,
    bool? canDraw,
    int? currentExercise,
    GameDialogMessageEvent? gameDialogMessage,
  }) {
    return GameState(
      gameDialogMessage: gameDialogMessage ?? this.gameDialogMessage,
      //upperDialogMesage: upperDialogMessage ?? this.upperDialogMesage,
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
