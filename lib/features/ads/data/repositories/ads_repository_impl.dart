import 'package:dartz/dartz.dart';
import 'package:flutter_math_app/core/error/exceptions.dart';
import 'package:flutter_math_app/core/error/failure.dart';
import 'package:flutter_math_app/features/ads/data/datasources/admob_datasource.dart';
import 'package:flutter_math_app/features/ads/domain/repositories/ads_repository.dart';

class AdsRepositoryImpl implements AdsRepository {
  final AdmobDataSource _dataSource;
  AdsRepositoryImpl({required AdmobDataSource dataSource}) : _dataSource = dataSource;

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
}
