part of 'input_recognition_cubit.dart';

enum InputRecognitionStatus { idle, success, failed, processing }

final class InputRecognitionState extends Equatable {
  final InputRecognitionStatus status;
  final int? numberRecognized;
  final String? errorMessage;

  const InputRecognitionState({
    this.status = InputRecognitionStatus.idle,
    this.numberRecognized,
    this.errorMessage,
  });

  InputRecognitionState copyWith({
    InputRecognitionStatus? status,
    int? numberRecognized,
    String? errorMessage,
  }) {
    return InputRecognitionState(
      status: status ?? this.status,
      numberRecognized: numberRecognized ?? this.numberRecognized,
      errorMessage: errorMessage,
    );
  }

  bool get isStatusFailure => status == InputRecognitionStatus.failed;

  @override
  List<Object?> get props => [
    status,
    numberRecognized,
    errorMessage,
  ];
}
