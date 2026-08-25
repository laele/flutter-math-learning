import 'package:collection/collection.dart';
import 'package:flutter_math_app/core/error/exceptions.dart';
import 'package:flutter_math_app/features/game/data/models/game_operation_stats_embedded.dart';
import 'package:flutter_math_app/features/game/data/models/game_stats_model.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_stats_entity.dart';
import 'package:flutter_math_app/features/game/domain/enums/operation_type.dart';
import 'package:isar_community/isar.dart';

abstract interface class GameStatsLocalDataSource {
  Future<Map<OperationType, GameStatsEntity>> getAllStats();
  Future<void> saveStats({required Map<OperationType, GameStatsEntity> stats});
}

class GameStatsLocalDataSourceImpl implements GameStatsLocalDataSource {
  final Isar _isar;
  static const int _singletonId = 0;

  GameStatsLocalDataSourceImpl({required Isar isar}) : _isar = isar;

  @override
  Future<Map<OperationType, GameStatsEntity>> getAllStats() async {
    try {
      final model = await _isar.gameStatsModels.get(_singletonId);
      if (model == null) return {};

      final result = <OperationType, GameStatsEntity>{};

      for (final entry in model.entries) {
        final operationType = OperationType.values.firstWhereOrNull((m) => m.name == entry.operationTypeKey);
        if (operationType == null) continue;

        result[operationType] = GameStatsEntity(
          correctCount: entry.correctCount,
          attempts: entry.attempts,
          currentTierIndex: entry.currentTierIndex,
          recentResults: entry.recentResults,
        );
      }
      return result;
    } catch (e) {
      throw LocalStorageException(message: e.toString());
    }
  }

  @override
  Future<void> saveStats({required Map<OperationType, GameStatsEntity> stats}) async {
    try {
      final model = GameStatsModel()
        ..id = _singletonId
        ..entries = stats.entries.map(
          (e) {
            return GameOperationStatsEmbedded()
              ..operationTypeKey = e.key.name
              ..currentTierIndex = e.value.currentTierIndex
              ..correctCount = e.value.correctCount
              ..attempts = e.value.attempts
              ..recentResults = e.value.recentResults;
          },
        ).toList();

      await _isar.writeTxn(
        () async {
          await _isar.gameStatsModels.put(model);
        },
      );
    } catch (e) {
      throw LocalStorageException(message: e.toString());
    }
  }
}
