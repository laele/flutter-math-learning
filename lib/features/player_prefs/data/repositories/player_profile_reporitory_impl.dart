import 'package:dartz/dartz.dart';
import 'package:flutter_math_app/core/error/exceptions.dart';
import 'package:flutter_math_app/core/error/failure.dart';
import 'package:flutter_math_app/features/player_prefs/data/datasource/player_profile_local_datasource.dart';
import 'package:flutter_math_app/features/player_prefs/data/models/player_profile_model.dart';
import 'package:flutter_math_app/features/player_prefs/domain/entities/player_profile_entity.dart';
import 'package:flutter_math_app/features/player_prefs/domain/repositories/player_profile_repository.dart';

class PlayerProfileReporitoryImpl implements PlayerProfileRepository {
  final PlayerProfileLocalDataSource _localDataSource;

  PlayerProfileReporitoryImpl({required PlayerProfileLocalDataSource localDataSource}) : _localDataSource = localDataSource;

  @override
  Future<Either<Failure, PlayerProfileEntity>> getPlayerProfile() async {
    try {
      final model = await _localDataSource.getPlayerProfile();
      print('----------- loaded profile');
      print(model?.toEntity());
      return right(model?.toEntity() ?? const PlayerProfileEntity());
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.message));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PlayerProfileEntity>> saveBestScore({required int score}) async {
    try {
      final currentProfile = await getPlayerProfile();
      return currentProfile.fold(
        (failure) => left(failure),
        (playerProfile) async {
          if (score <= playerProfile.bestArcadeScore) {
            return right(playerProfile);
          }

          final updated = playerProfile.copyWith(bestArcadeScore: score);

          try {
            await _localDataSource.saveProfile(PlayerProfileModel.fromEntity(updated));
          } on LocalStorageException catch (e) {
            return left(LocalStorageFailure(message: e.toString()));
          }

          return right(updated);
        },
      );
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PlayerProfileEntity>> updatePlayerName({required String name}) async {
    try {
      final currentProfile = await getPlayerProfile();
      return currentProfile.fold(
        (failure) => left(failure),
        (playerProfile) async {
          final updated = playerProfile.copyWith(playerName: name);

          try {
            await _localDataSource.saveProfile(PlayerProfileModel.fromEntity(updated));
            return right(updated);
          } on LocalStorageException catch (e) {
            return left(LocalStorageFailure(message: e.toString()));
          }
        },
      );
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }
}
