import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide Ink;
import 'package:flutter_math_app/core/error/failure.dart';
import 'package:flutter_math_app/core/usecase/usecase.dart';
import 'package:flutter_math_app/features/input_recognition/domain/entities/drawn_point_entity.dart';
import 'package:flutter_math_app/features/input_recognition/domain/entities/drawn_stroke_entity.dart';
import 'package:flutter_math_app/features/input_recognition/domain/enums/input_recognition_error_type.dart';
import 'package:flutter_math_app/features/input_recognition/domain/failures/input_recognition_failure.dart';
import 'package:flutter_math_app/features/input_recognition/domain/usecases/ensure_model_downloaded_usecase.dart';
import 'package:flutter_math_app/features/input_recognition/domain/usecases/recognize_number_usecase.dart';
import 'package:scribble/scribble.dart';

part 'input_recognition_state.dart';

class InputRecognitionCubit extends Cubit<InputRecognitionState> {
  final ScribbleNotifier notifier = ScribbleNotifier();
  Timer? _timer;
  final RecognizeNumberUseCase _recognizeNumberUseCase;
  final EnsureModelDownloadedUseCase _ensureModelDownloadedUseCase;

  static const _submitTime = Duration(milliseconds: 1400);

  InputRecognitionCubit({
    required RecognizeNumberUseCase recognizeNumberUseCase,
    required EnsureModelDownloadedUseCase ensureModelDownloaded,
  }) : _recognizeNumberUseCase = recognizeNumberUseCase,
       _ensureModelDownloadedUseCase = ensureModelDownloaded,
       super(InputRecognitionState());

  void initNotifier() {
    notifier.setColor(Color.fromARGB(255, 255, 255, 255));
    notifier.setStrokeWidth(10.0);
  }

  void onStartedStroke() {
    _timer?.cancel();
  }

  void onFinishedStroke({
    required double canvasWidth,
    required double canvasHeight,
  }) {
    _timer?.cancel();
    _timer = Timer(
      _submitTime,
      () {
        submitResult(canvasWidth: canvasWidth, canvasHeight: canvasHeight);
      },
    );
  }

  void clearCanvas() {
    notifier.clear();
    _timer?.cancel();
  }

  void ensureModelDownloaded() async {
    emit(state.copyWith(status: InputRecognitionStatus.processing));
    final ensuremodelDownloaded = await _ensureModelDownloadedUseCase(
      NoParams(),
    );
    ensuremodelDownloaded.fold(
      (failure) {
        emit(
          state.copyWith(
            status: InputRecognitionStatus.failed,
            errorType: _errorTypeFromFailure(failure),
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            status: InputRecognitionStatus.success,
            isLoaded: true,
          ),
        );
      },
    );
  }

  void retry() {
    ensureModelDownloaded();
  }

  void submitResult({
    required double canvasWidth,
    required double canvasHeight,
  }) async {
    final strokes = notifier.currentSketch.lines.map(
      (line) {
        return DrawnStrokeEntity(
          points: line.points
              .map(
                (point) => DrawnPointEntity(
                  x: point.x,
                  y: point.y,
                ),
              )
              .toList(),
        );
      },
    ).toList();
    emit(state.copyWith(status: InputRecognitionStatus.processing));

    final result = await _recognizeNumberUseCase(
      RecognizeNumberParams(
        strokes: strokes,
        canvasWidth: canvasWidth,
        canvasHeight: canvasHeight,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: InputRecognitionStatus.failed,
            errorType: _errorTypeFromFailure(failure),
          ),
        );
      },
      (number) {
        emit(
          state.copyWith(
            numberRecognized: number,
            status: InputRecognitionStatus.success,
          ),
        );
      },
    );

    emit(state.copyWith(status: InputRecognitionStatus.idle));
  }

  @override
  Future<void> close() {
    notifier.dispose();
    _timer?.cancel();
    return super.close();
  }

  InputRecognitionErrorType? _errorTypeFromFailure(Failure failure) {
    return switch (failure) {
      ModelNotDownloadedFailure() =>
        InputRecognitionErrorType.modelNotDownloaded,
      EmptyInputFailure() => InputRecognitionErrorType.emptyInput,
      UnrecognizedInputFailure() => InputRecognitionErrorType.unrecognized,
      _ => InputRecognitionErrorType.unknown,
    };
  }
}
