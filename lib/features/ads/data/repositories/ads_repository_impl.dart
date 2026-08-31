import 'package:dartz/dartz.dart';
import 'package:flutter_math_app/core/error/exceptions.dart';
import 'package:flutter_math_app/core/error/failure.dart';
import 'package:flutter_math_app/features/ads/data/datasources/admob_datasource.dart';
import 'package:flutter_math_app/features/ads/data/datasources/ads_local_datasource.dart';
import 'package:flutter_math_app/features/ads/domain/repositories/ads_repository.dart';

class AdsRepositoryImpl implements AdsRepository {
  final AdmobDataSource _dataSource;
  final AdsLocalDataSource _localDataSource;
  AdsRepositoryImpl({
    required AdmobDataSource dataSource,
    required AdsLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource,
       _dataSource = dataSource;

  @override
  Future<Either<Failure, void>> initialize() async {
    try {
      await _dataSource.initialize();
      return right(null);
    } catch (e) {
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, void>> loadInterstitial() async {
    try {
      await _dataSource.loadInterstitial();
      return right(null);
    } on AdLoadException catch (e) {
      return left(UnexpectedFailure());
    } catch (e) {
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> showInterstitialIfReady() async {
    try {
      final shown = await _dataSource.showInterstitialIfReady();
      return right(shown);
    } catch (e) {
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, DateTime?>> getLastShownAt() async {
    try {
      final date = await _localDataSource.getLastAdShownAt();
      return right(date);
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getSessionsSinceLastAd() async {
    try {
      final sessions = await _localDataSource.getSessionsSinceLastAd();
      return right(sessions);
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> recordAdShown() async {
    try {
      await _localDataSource.resetSessionsCounter();
      await _localDataSource.setLastAdShownAt(DateTime.now());
      return right(null);
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> recordSessionCompleted() async {
    try {
      await _localDataSource.incrementSessionsSinceLastAd();
      return right(null);
    } on LocalStorageException catch (e) {
      return left(LocalStorageFailure(message: e.toString()));
    }
  }
}
