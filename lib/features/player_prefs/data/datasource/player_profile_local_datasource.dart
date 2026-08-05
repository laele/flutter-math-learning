import 'package:flutter_math_app/core/error/exceptions.dart';
import 'package:flutter_math_app/features/player_prefs/data/models/player_profile_model.dart';
import 'package:isar_community/isar.dart';

abstract interface class PlayerProfileLocalDataSource {
  Future<PlayerProfileModel?> getPlayerProfile();
  Future<void> saveProfile(PlayerProfileModel profile);
}

class PlayerProfileLocalDatasourceImpl implements PlayerProfileLocalDataSource {
  final Isar _isar;

  PlayerProfileLocalDatasourceImpl({required Isar isar}) : _isar = isar;

  @override
  Future<PlayerProfileModel?> getPlayerProfile() async {
    try {
      return await _isar.playerProfileModels.where().findFirst();
    } catch (e) {
      throw LocalStorageException(message: e.toString());
    }
  }

  @override
  Future<void> saveProfile(profile) async {
    try {
      return await _isar.writeTxn(
        () async {
          await _isar.playerProfileModels.put(profile);
        },
      );
    } catch (e) {
      throw LocalStorageException(message: e.toString());
    }
  }
}
