import 'package:dartz/dartz.dart';
import 'package:flutter_math_app/core/error/failure.dart';
import 'package:flutter_math_app/core/usecase/usecase.dart';
import 'package:flutter_math_app/features/player_prefs/domain/entities/player_profile_entity.dart';
import 'package:flutter_math_app/features/player_prefs/domain/repositories/player_profile_repository.dart';

class UpdatePlayerNameUseCase implements UseCase<PlayerProfileEntity, String> {
  final PlayerProfileRepository _repository;
  const UpdatePlayerNameUseCase({required PlayerProfileRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, PlayerProfileEntity>> call(String name) async {
    return await _repository.updatePlayerName(name: name);
  }
}
