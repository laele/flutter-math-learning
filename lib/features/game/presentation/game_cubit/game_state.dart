part of 'game_cubit.dart';

enum GameMode { learnNumbers, add, sub, mult, div }

class GameState extends Equatable {
  final GameSoundEvent? soundEvent;
  final GameEffectEvent? effectEvent;
  final GameAnimationEvent? animationEvent;

  final GameSessionEntity gameSession;
  final bool showScore;
  final Map<GameMode, GameStatsEntity> stats;

  final GameMode? currentGameMode;
  final List<GameMode> selectedGameModes;

  final int currentExercise;

  final String? message;

  final int? firstNum;
  final int? secNum;
  final int? result;

  final bool canDraw;
  final bool showMenu;
  final bool hideOperation;

  const GameState({
    required this.selectedGameModes,
    required this.currentExercise,
    required this.hideOperation,
    this.animationEvent,
    this.soundEvent,
    this.effectEvent,
    this.currentGameMode,
    this.message,
    this.result,
    this.firstNum,
    this.secNum,
    this.showScore = false,
    this.stats = const {},
    this.gameSession = const GameSessionEntity(),
    this.canDraw = false,
    this.showMenu = true,
  });

  GameStatsEntity get currentGameStats => stats[currentGameMode] ?? GameStatsEntity();
  GameStatsEntity gameStats(GameMode gameMode) => stats[gameMode] ?? GameStatsEntity();
  String get currentGameModeOperator => switch (currentGameMode) {
    GameMode.add => '+',
    GameMode.sub => '-',
    GameMode.mult => '×',
    GameMode.div => '÷',
    _ => '',
  };

  GameState copyWith({
    bool? showScore,
    GameSessionEntity? gameSession,
    GameEffectEvent? effectEvent,
    GameSoundEvent? soundEvent,
    GameAnimationEvent? animationEvent,
    bool? showMenu,
    Map<GameMode, GameStatsEntity>? stats,
    GameMode? gameMode,
    GameMode? currentGameMode,
    List<GameMode>? selectedGameModes,
    String? message,
    int? result,
    int? firstNum,
    int? secNum,
    bool? readyToClearMessage,
    bool? canDraw,
    int? currentExercise,
    bool? hideOperation,
  }) {
    return GameState(
      showScore: showScore ?? this.showScore,
      gameSession: gameSession ?? this.gameSession,
      soundEvent: soundEvent ?? this.soundEvent,
      effectEvent: effectEvent ?? this.effectEvent,
      animationEvent: animationEvent ?? this.animationEvent,
      hideOperation: hideOperation ?? this.hideOperation,
      showMenu: showMenu ?? this.showMenu,
      currentGameMode: currentGameMode ?? this.currentGameMode,
      selectedGameModes: selectedGameModes ?? this.selectedGameModes,
      stats: stats ?? this.stats,
      message: message ?? this.message,
      result: result ?? this.result,
      firstNum: firstNum ?? this.firstNum,
      secNum: secNum ?? this.secNum,
      canDraw: canDraw ?? this.canDraw,
      currentExercise: currentExercise ?? this.currentExercise,
    );
  }

  @override
  List<Object?> get props => [
    soundEvent,
    effectEvent,
    animationEvent,
    hideOperation,
    showMenu,
    stats,
    message,
    result,
    firstNum,
    secNum,
    canDraw,
    selectedGameModes,
    currentExercise,
    currentGameMode,
    gameSession,
    showScore,
  ];
}
