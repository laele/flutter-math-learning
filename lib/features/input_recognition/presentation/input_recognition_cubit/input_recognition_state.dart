part of 'input_recognition_cubit.dart';

enum InputRecognitionStatus { idle, success, failed, processing }

final class InputRecognitionState extends Equatable {
  final bool isLoaded;
  final InputRecognitionStatus status;
  final int? numberRecognized;
  final InputRecognitionErrorType? errorType;

  const InputRecognitionState({
    this.isLoaded = false,
    this.status = InputRecognitionStatus.idle,
    this.numberRecognized,
    this.errorType,
  });

  InputRecognitionState copyWith({
    bool? isLoaded,
    InputRecognitionStatus? status,
    int? numberRecognized,
    InputRecognitionErrorType? errorType,
  }) {
    return InputRecognitionState(
      isLoaded: isLoaded ?? this.isLoaded,
      status: status ?? this.status,
      numberRecognized: numberRecognized ?? this.numberRecognized,
      errorType: errorType,
    );
  }

  bool get isStatusFailure => status == InputRecognitionStatus.failed;

  @override
  List<Object?> get props => [
    isLoaded,
    status,
    numberRecognized,
    errorType,
  ];
}
