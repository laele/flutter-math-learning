import 'package:dartz/dartz.dart';
import 'package:flutter_math_app/core/error/failure.dart';

abstract interface class SettingsRepository {
  Future<Either<Failure, String?>> getLocaleCode(); // if null then use device lang
  Future<Either<Failure, void>> saveLocaleCode({String? code});
}
