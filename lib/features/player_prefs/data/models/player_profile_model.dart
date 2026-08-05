import 'package:flutter_math_app/features/player_prefs/domain/entities/player_profile_entity.dart';
import 'package:isar_community/isar.dart';

part 'player_profile_model.g.dart';

@collection
class PlayerProfileModel {
  Id id = Isar.autoIncrement;
  String playerName;
  int bestArcadeScore;

  PlayerProfileModel({
    this.playerName = 'Player',
    this.bestArcadeScore = 0,
  });

  PlayerProfileEntity toEntity() => PlayerProfileEntity(
    playerName: playerName,
    bestArcadeScore: bestArcadeScore,
  );

  factory PlayerProfileModel.fromEntity(PlayerProfileEntity entity) => PlayerProfileModel(
    playerName: entity.playerName,
    bestArcadeScore: entity.bestArcadeScore,
  );
}
