import 'package:dartz/dartz.dart';
import 'package:flutter_math_app/core/error/exceptions.dart';
import 'package:flutter_math_app/core/error/failure.dart';
import 'package:flutter_math_app/features/game/data/datasources/game_stats_local_datasource.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_stats_entity.dart';
import 'package:flutter_math_app/features/game/domain/enums/operation_type.dart';
import 'package:flutter_math_app/features/game/domain/repositories/game_stats_repository.dart';

class GameStatsRepositoryImpl implements GameStatsRepository {
  final GameStatsLocalDataSource _localDataSource;

  GameStatsRepositoryImpl({required GameStatsLocalDataSource localDataSource}) : _localDataSource = localDataSource;

  @override
  Future<Either<Failure, Map<OperationType, GameStatsEntity>>> getStats() async {
    try {
      final stats = await _localDataSource.getAllStats();
      return right(stats);
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.message));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveAllStats({required Map<OperationType, GameStatsEntity> stats}) async {
    try {
      await _localDataSource.saveStats(stats: stats);
      return right(null);
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.message));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }
}
