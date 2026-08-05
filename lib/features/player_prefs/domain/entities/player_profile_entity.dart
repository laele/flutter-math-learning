import 'package:equatable/equatable.dart';

class PlayerProfileEntity extends Equatable {
  final String playerName;
  final int bestArcadeScore;

  const PlayerProfileEntity({
    this.playerName = 'Player',
    this.bestArcadeScore = 0,
  });

  PlayerProfileEntity copyWith({
    String? playerName,
    int? bestArcadeScore,
    DateTime? lastPlayedAt,
  }) {
    return PlayerProfileEntity(
      playerName: playerName ?? this.playerName,
      bestArcadeScore: bestArcadeScore ?? this.bestArcadeScore,
    );
  }

  @override
  List<Object?> get props => [playerName, bestArcadeScore];
}
