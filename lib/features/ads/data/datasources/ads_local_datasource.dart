import 'package:flutter_math_app/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AdsLocalDataSource {
  Future<int> getSessionsSinceLastAd();
  Future<DateTime?> getLastAdShownAt();
  Future<void> incrementSessionsSinceLastAd();
  Future<void> resetSessionsCounter();
  Future<void> setLastAdShownAt(DateTime dateTime);
}

class AdsLocalDataSourceImpl implements AdsLocalDataSource {
  final SharedPreferences _prefs;
  static const _sessionsCounterKey = 'ads_sessions_counter';
  static const _lastShownKey = 'ads_last_shown_at';

  AdsLocalDataSourceImpl({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  Future<DateTime?> getLastAdShownAt() async {
    try {
      final millis = _prefs.getInt(_lastShownKey);
      return millis != null
          ? DateTime.fromMillisecondsSinceEpoch(millis)
          : null;
    } catch (e) {
      throw LocalStorageException(message: e.toString());
    }
  }

  @override
  Future<int> getSessionsSinceLastAd() async {
    try {
      return _prefs.getInt(_sessionsCounterKey) ?? 0;
    } catch (e) {
      throw LocalStorageException(message: e.toString());
    }
  }

  @override
  Future<void> incrementSessionsSinceLastAd() async {
    try {
      final current = await getSessionsSinceLastAd();
      await _prefs.setInt(_sessionsCounterKey, current + 1);
    } catch (e) {
      throw LocalStorageException(message: e.toString());
    }
  }

  @override
  Future<void> resetSessionsCounter() async {
    try {
      await _prefs.setInt(_sessionsCounterKey, 0);
    } catch (e) {
      throw LocalStorageException(message: e.toString());
    }
  }

  @override
  Future<void> setLastAdShownAt(DateTime dateTime) async {
    try {
      await _prefs.setInt(_lastShownKey, dateTime.millisecondsSinceEpoch);
    } catch (e) {
      throw LocalStorageException(message: e.toString());
    }
  }
}
