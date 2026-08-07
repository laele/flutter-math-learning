import 'package:dartz/dartz.dart';
import 'package:flutter_math_app/core/error/failure.dart';
import 'package:flutter_math_app/features/settings/domain/repository/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferences _prefs;
  static const _localeKey = 'selected_locale';

  SettingsRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  Future<Either<Failure, String?>> getLocaleCode() async {
    try {
      return right(_prefs.getString(_localeKey));
    } catch (e) {
      return left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveLocaleCode({String? code}) async {
    try {
      if (code == null) {
        await _prefs.remove(_localeKey);
      } else {
        await _prefs.setString(_localeKey, code);
      }
      return const Right(null);
    } catch (e) {
      return left(LocalStorageFailure(message: e.toString()));
    }
  }
}
