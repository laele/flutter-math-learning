part of 'splash_cubit.dart';

class SplashState extends Equatable {
  final SplashStatus status;
  final InputRecognitionErrorType? errorType;

  const SplashState({
    this.status = SplashStatus.loading,
    this.errorType,
  });

  SplashState copyWith({
    SplashStatus? status,
    InputRecognitionErrorType? errorType,
  }) {
    return SplashState(
      status: status ?? this.status,
      errorType: this.errorType,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorType,
  ];
}
