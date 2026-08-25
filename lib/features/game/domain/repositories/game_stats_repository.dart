import 'package:dartz/dartz.dart';
import 'package:flutter_math_app/core/error/failure.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_stats_entity.dart';
import 'package:flutter_math_app/features/game/domain/enums/operation_type.dart';

abstract interface class GameStatsRepository {
  Future<Either<Failure, Map<OperationType, GameStatsEntity>>> getStats();
  Future<Either<Failure, void>> saveAllStats({required Map<OperationType, GameStatsEntity> stats});
}
