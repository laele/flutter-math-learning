import 'package:isar_community/isar.dart';

part 'game_operation_stats_embedded.g.dart';

@embedded
class GameOperationStatsEmbedded {
  String operationTypeKey = '';

  List<bool> recentResults = [];
  int currentTierIndex = 0;
  int attempts = 0;
  int correctCount = 0;
}
