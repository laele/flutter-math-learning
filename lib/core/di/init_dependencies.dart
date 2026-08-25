import 'dart:io';

import 'package:flutter_math_app/features/dialog_message/data/datasources/dialog_message_pool_en.dart';
import 'package:flutter_math_app/features/dialog_message/data/datasources/dialog_message_pool_es.dart';
import 'package:flutter_math_app/features/dialog_message/data/datasources/dialog_message_pool_fr.dart';
import 'package:flutter_math_app/features/dialog_message/data/datasources/dialog_message_pool_hi.dart';
import 'package:flutter_math_app/features/dialog_message/data/datasources/dialog_message_pool_ja.dart';
import 'package:flutter_math_app/features/dialog_message/data/datasources/dialog_message_pool_ko.dart';
import 'package:flutter_math_app/features/dialog_message/data/datasources/dialog_message_pool_pt.dart';
import 'package:flutter_math_app/features/dialog_message/data/datasources/dialog_message_pool_tl.dart';
import 'package:flutter_math_app/features/dialog_message/data/datasources/dialog_message_pool_zh.dart';
import 'package:flutter_math_app/features/dialog_message/data/repositories/dialog_message_repository_impl.dart';
import 'package:flutter_math_app/features/dialog_message/domain/repositories/dialog_message_repository.dart';
import 'package:flutter_math_app/features/effects/presentation/cubit/effects_cubit.dart';
import 'package:flutter_math_app/features/audio/data/datasource/audio_datasource.dart';
import 'package:flutter_math_app/features/audio/data/repositories/audio_repository_impl.dart';
import 'package:flutter_math_app/features/audio/domain/repositories/audio_repository.dart';
import 'package:flutter_math_app/features/audio/presentation/cubit/audio_cubit.dart';
import 'package:flutter_math_app/features/character/presentation/cubit/character_cubit.dart';
import 'package:flutter_math_app/features/dialog_message/presentation/cubit/dialog_message_cubit.dart';
import 'package:flutter_math_app/features/game/data/datasources/game_stats_local_datasource.dart';
import 'package:flutter_math_app/features/game/data/models/game_stats_model.dart';
import 'package:flutter_math_app/features/game/data/repositories/game_stats_repository_impl.dart';
import 'package:flutter_math_app/features/game/domain/repositories/game_stats_repository.dart';
import 'package:flutter_math_app/features/game/domain/services/game_rules_policy.dart';
import 'package:flutter_math_app/features/game/domain/usecases/get_game_stats_usecase.dart';
import 'package:flutter_math_app/features/game/domain/usecases/save_game_stats_usecase.dart';
import 'package:flutter_math_app/features/game/presentation/game_cubit/game_cubit.dart';
import 'package:flutter_math_app/features/game/score/cubit/score_cubit.dart';
import 'package:flutter_math_app/features/game/timer/presentation/cubit/timer_cubit.dart';
import 'package:flutter_math_app/features/input_recognition/data/datasource/input_recognition_datasource.dart';
import 'package:flutter_math_app/features/input_recognition/data/repository/input_recognition_repository_impl.dart';
import 'package:flutter_math_app/features/input_recognition/domain/repository/input_recognition_repository.dart';
import 'package:flutter_math_app/features/input_recognition/domain/usecases/ensure_model_downloaded_usecase.dart';
import 'package:flutter_math_app/features/input_recognition/domain/usecases/recognize_number_usecase.dart';
import 'package:flutter_math_app/features/input_recognition/presentation/input_recognition_cubit/input_recognition_cubit.dart';
import 'package:flutter_math_app/features/player_prefs/data/datasource/player_profile_local_datasource.dart';
import 'package:flutter_math_app/features/player_prefs/data/models/player_profile_model.dart';
import 'package:flutter_math_app/features/player_prefs/data/repositories/player_profile_reporitory_impl.dart';
import 'package:flutter_math_app/features/player_prefs/domain/repositories/player_profile_repository.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/cubit/player_profile_cubit.dart';
import 'package:flutter_math_app/features/scenes/presentation/splash/splash_cubit/splash_cubit.dart';
import 'package:flutter_math_app/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:flutter_math_app/features/settings/domain/repository/settings_repository.dart';
import 'package:flutter_math_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter_math_app/features/tutorial/presentation/cubit/tutorial_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar_community/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  final isarInstance = await Isar.open([
    PlayerProfileModelSchema,
    GameStatsModelSchema,
  ], directory: (await getApplicationDocumentsDirectory()).path);

  // TODO DELETE clear shared prefs
  await sharedPrefs.clear();
  // TODO CLEAR ISAR DATA
  await isarInstance.writeTxn(() async {
    await isarInstance.playerProfileModels.clear();
    await isarInstance.gameStatsModels.clear();
  });
  //

  sl.registerLazySingleton<Isar>(() => isarInstance);
  await initInputRecognizer();
  await initAudio();
  await initPlayerProfile();
  await initDialogMessage();
  await initSettings(instance: sharedPrefs);
  await initGame();

  sl.registerFactory<EffectsCubit>(() => EffectsCubit()); // effect animaiton
  sl.registerFactory<CharacterCubit>(
    () => CharacterCubit(),
  ); // Character Animation Cubit
  sl.registerFactory<TimerCubit>(() => TimerCubit());
  sl.registerFactory<ScoreCubit>(() => ScoreCubit());
  sl.registerFactory<TutorialCubit>(() => TutorialCubit());
}

Future<void> initGame() async {
  sl.registerLazySingleton<GameStatsLocalDataSource>(
    () => GameStatsLocalDataSourceImpl(isar: sl()),
  );
  sl.registerLazySingleton<GameStatsRepository>(
    () => GameStatsRepositoryImpl(localDataSource: sl()),
  );
  sl.registerFactory<GetGameStatsUseCase>(
    () => GetGameStatsUseCase(repository: sl()),
  );
  sl.registerFactory<SaveGameStatsUseCase>(
    () => SaveGameStatsUseCase(repository: sl()),
  );

  sl.registerFactoryParam<GameCubit, GameRulesPolicy, void>(
    (policy, _) => GameCubit(
      rulesPolicy: policy,
      getGameStatsUseCase: sl(),
      saveGameStatsUseCase: sl(),
    ),
  );
}

Future<void> initPlayerProfile() async {
  sl
    ..registerLazySingleton<PlayerProfileLocalDataSource>(
      () => PlayerProfileLocalDatasourceImpl(isar: sl()),
    )
    ..registerLazySingleton<PlayerProfileRepository>(
      () => PlayerProfileReporitoryImpl(localDataSource: sl()),
    )
    ..registerFactory<PlayerProfileCubit>(
      () => PlayerProfileCubit(repository: sl()),
    );
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
    ..registerLazySingleton<AudioDataSource>(() => AudioDataSourceImpl())
    ..registerLazySingleton<AudioRepository>(
      () => AudioRepositoryImpl(datasource: sl()),
    )
    ..registerLazySingleton<AudioCubit>(
      () => AudioCubit(audioRepository: sl()),
    );
}

Future<void> initSettings({required SharedPreferences instance}) async {
  sl
    ..registerLazySingleton<SharedPreferences>(() => instance)
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(prefs: sl()),
    )
    ..registerFactory<SettingsCubit>(
      () => SettingsCubit(
        settingsRepository: sl(),
        dialogRepository: sl(),
      ),
    );
}

Future<void> initDialogMessage() async {
  sl
    ..registerLazySingleton<DialogMessageRepository>(
      () => DialogMessageRepositoryImpl(
        poolsByLocale: {
          'en': dialogMessagePoolEn, // 'en' as default first position
          'es': dialogMessagePoolEs,
          'pt': dialogMessagePoolPt,
          'zh': dialogMessagePoolZh,
          'fr': dialogMessagePoolFr,
          'ja': dialogMessagePoolJa,
          'ko': dialogMessagePoolKo,
          'hi': dialogMessagePoolHi,
          'tl': dialogMessagePoolTl,
        },
      ),
    )
    ..registerFactory<DialogMessageCubit>(
      () => DialogMessageCubit(repository: sl()),
    );
}
