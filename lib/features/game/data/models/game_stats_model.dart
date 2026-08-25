import 'package:flutter_math_app/features/game/data/models/game_operation_stats_embedded.dart';
import 'package:isar_community/isar.dart';

part 'game_stats_model.g.dart';

@collection
class GameStatsModel {
  Id id = 0;
  List<GameOperationStatsEmbedded> entries = [];
}
