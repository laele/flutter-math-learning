import 'package:dartz/dartz.dart';
import 'package:flutter_math_app/core/error/failure.dart';
import 'package:flutter_math_app/core/usecase/usecase.dart';
import 'package:flutter_math_app/features/game/domain/entities/game_stats_entity.dart';
import 'package:flutter_math_app/features/game/domain/enums/operation_type.dart';
import 'package:flutter_math_app/features/game/domain/repositories/game_stats_repository.dart';

class SaveGameStatsUseCase implements UseCase<void, Map<OperationType, GameStatsEntity>> {
  final GameStatsRepository _repository;

  const SaveGameStatsUseCase({required GameStatsRepository repository}) : _repository = repository;
  @override
  Future<Either<Failure, dynamic>> call(params) async {
    return await _repository.saveAllStats(stats: params);
  }
}
