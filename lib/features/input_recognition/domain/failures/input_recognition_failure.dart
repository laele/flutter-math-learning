import 'package:flutter_math_app/core/error/failure.dart';

class ModelNotDownloadedFailure extends Failure {
  const ModelNotDownloadedFailure({super.message = ''});

  @override
  List<Object?> get props => [];
}

class EmptyInputFailure extends Failure {
  const EmptyInputFailure({super.message = ''});

  @override
  List<Object?> get props => [];
}

class UnrecognizedInputFailure extends Failure {
  const UnrecognizedInputFailure({super.message = ''});

  @override
  List<Object?> get props => [];
}

class UnknownInputRecognitionFailure extends Failure {
  const UnknownInputRecognitionFailure({super.message = ''});
  @override
  List<Object?> get props => [];
}
