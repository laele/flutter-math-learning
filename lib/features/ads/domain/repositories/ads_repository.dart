import 'package:dartz/dartz.dart';
import 'package:flutter_math_app/core/error/failure.dart';

abstract interface class AdsRepository {
  Future<Either<Failure, void>> initialize();
  Future<Either<Failure, void>> loadInterstitial();
  Future<Either<Failure, bool>> showInterstitialIfReady();
}
