import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_math_app/features/input_recognition/domain/entities/drawn_stroke_entity.dart';
import 'package:flutter_math_app/features/input_recognition/domain/failures/input_recognition_exception.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';

abstract class InputRecognitionDataSource {
  Future<void> ensureModelDownloaded();

  Future<String> getNumber({
    required List<DrawnStrokeEntity> strokes,
    required double canvasWidth,
    required double canvasHeight,
  });
}

class InputRecognitionDataSourceImpl extends InputRecognitionDataSource {
  final _modelManager = DigitalInkRecognizerModelManager();
  late final DigitalInkRecognizer _recognizer;
  static bool debugForceDownloadFailure = false;
  final Connectivity _connectivity;
  static const _downloadTimeout = Duration(seconds: 15);

  //InputRecognitionDataSourceImpl({required DigitalInkRecognizer recognizer}) : _recognizer = recognizer;

  InputRecognitionDataSourceImpl({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity(),
      _recognizer = DigitalInkRecognizer(languageCode: 'en');

  @override
  Future<void> ensureModelDownloaded() async {
    if (debugForceDownloadFailure) {
      throw const ModelNotDownloadedException();
    }

    final isModelDownloaded = await _modelManager.isModelDownloaded('en');
    if (isModelDownloaded) return;

    final connectivityResult = await _connectivity.checkConnectivity();
    final hasConnection = !connectivityResult.contains(ConnectivityResult.none);
    if (!hasConnection) {
      throw const ModelNotDownloadedException();
    }

    try {
      final result = await _modelManager
          .downloadModel('en')
          .timeout(_downloadTimeout);
      if (!result) throw const ModelNotDownloadedException();
    } on TimeoutException {
      throw const ModelNotDownloadedException();
    }
  }

  @override
  Future<String> getNumber({
    required List<DrawnStrokeEntity> strokes,
    required double canvasWidth,
    required double canvasHeight,
  }) async {
    if (strokes.isEmpty) throw const EmptyStrokesException();
    final ink = _inkConverter(strokes);
    final context = DigitalInkRecognitionContext(
      preContext: '0123456789',
      writingArea: WritingArea(
        width: canvasWidth,
        height: canvasHeight,
      ),
    );
    final candidates = await _recognizer.recognize(ink, context: context);
    if (candidates.isEmpty) throw const NoRecognitionCandidateException();
    //print('Candidato reconocido: "${candidates.first.text}"');
    return candidates.first.text;
  }

  Ink _inkConverter(List<DrawnStrokeEntity> strokes) {
    final ink = Ink();
    for (final drawnStroke in strokes) {
      final stroke = Stroke();
      stroke.points = drawnStroke.points.map(
        (point) {
          return StrokePoint(
            x: point.x,
            y: point.y,
            t: DateTime.now().millisecondsSinceEpoch,
          );
        },
      ).toList();
      ink.strokes.add(stroke);
    }
    return ink;
  }

  void dispose() => _recognizer.close();
}
