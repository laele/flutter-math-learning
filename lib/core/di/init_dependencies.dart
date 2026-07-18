import 'package:flutter_math_app/features/audio/data/datasource/audio_datasource.dart';
import 'package:flutter_math_app/features/audio/data/repositories/audio_repository_impl.dart';
import 'package:flutter_math_app/features/audio/domain/repositories/audio_repository.dart';
import 'package:flutter_math_app/features/audio/presentation/cubit/audio_cubit.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';
import 'package:flutter_math_app/features/input_recognition/data/datasource/input_recognition_datasource.dart';
import 'package:flutter_math_app/features/input_recognition/data/repository/input_recognition_repository_impl.dart';
import 'package:flutter_math_app/features/input_recognition/domain/repository/input_recognition_repository.dart';
import 'package:flutter_math_app/features/input_recognition/domain/usecases/ensure_model_downloaded_usecase.dart';
import 'package:flutter_math_app/features/input_recognition/domain/usecases/recognize_number_usecase.dart';
import 'package:flutter_math_app/features/input_recognition/presentation/input_recognition_cubit/input_recognition_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await initInputRecognizer();
  await initAudio();
  sl.registerFactory<GameCubit>(() => GameCubit());
}

Future<void> initInputRecognizer() async {
  sl
    ..registerLazySingleton<InputRecognitionDataSource>(
      () => InputRecognitionDataSourceImpl(),
    )
    ..registerLazySingleton<InputRecognitionRepository>(
      () => InputRecognitionRepositoryImpl(datasource: sl()),
    )
    ..registerFactory<RecognizeNumberUseCase>(
      () => RecognizeNumberUseCase(inputRecognitionRepository: sl()),
    )
    ..registerFactory<EnsureModelDownloadedUseCase>(
      () => EnsureModelDownloadedUseCase(inputRecognitionRepository: sl()),
    )
    ..registerFactory<InputRecognitionCubit>(
      () => InputRecognitionCubit(
        recognizeNumberUseCase: sl(),
        ensureModelDownloaded: sl(),
      ),
    );
}

Future<void> initAudio() async {
  sl
    ..registerLazySingleton<AudioDataSource>(
      () => AudioDataSourceImpl(),
    )
    ..registerLazySingletonAsync<AudioRepository>(() async {
      final repo = AudioRepositoryImpl(datasource: sl());
      await repo.init(); // load sfx
      return repo;
    })
    ..registerFactory<AudioCubit>(() => AudioCubit(audioRepository: sl()));
  await sl.isReady<AudioRepository>();
}
