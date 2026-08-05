import 'package:dartz/dartz.dart';
import 'package:flutter_math_app/core/error/failure.dart';
import 'package:flutter_math_app/core/usecase/usecase.dart';
import 'package:flutter_math_app/features/player_prefs/domain/entities/player_profile_entity.dart';
import 'package:flutter_math_app/features/player_prefs/domain/repositories/player_profile_repository.dart';

class SaveBestScoreUsecase implements UseCase<PlayerProfileEntity, int> {
  final PlayerProfileRepository _repository;

  const SaveBestScoreUsecase({required PlayerProfileRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, PlayerProfileEntity>> call(int score) async {
    return await _repository.saveBestScore(score: score);
  }
}
