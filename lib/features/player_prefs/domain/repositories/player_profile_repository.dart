import 'package:dartz/dartz.dart';
import 'package:flutter_math_app/core/error/failure.dart';
import 'package:flutter_math_app/features/player_prefs/domain/entities/player_profile_entity.dart';

abstract interface class PlayerProfileRepository {
  Future<Either<Failure, PlayerProfileEntity>> getPlayerProfile();
  Future<Either<Failure, PlayerProfileEntity>> saveBestScore({required int score});
  Future<Either<Failure, PlayerProfileEntity>> updatePlayerName({required String name});
}
