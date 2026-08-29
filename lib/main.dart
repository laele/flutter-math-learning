import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/di/init_dependencies.dart';
import 'package:flutter_math_app/core/l10n/app_supported_locales.dart';
import 'package:flutter_math_app/core/l10n/arb/app_localizations.dart';
import 'package:flutter_math_app/core/theme/app_theme.dart';
import 'package:flutter_math_app/features/ads/presentation/cubit/ads_cubit.dart';
import 'package:flutter_math_app/features/audio/presentation/cubit/audio_cubit.dart';
import 'package:flutter_math_app/features/audio/presentation/widgets/audio_listener.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/cubit/player_profile_cubit.dart';
import 'package:flutter_math_app/features/scenes/presentation/splash/splash_screen.dart';
import 'package:flutter_math_app/features/input_recognition/presentation/input_recognition_cubit/input_recognition_cubit.dart';
import 'package:flutter_math_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:rive/rive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RiveNative.init();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AdsCubit>()..initialize(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => sl<SettingsCubit>()..loadSavedLocale(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => sl<PlayerProfileCubit>()..loadProfile(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => sl<InputRecognitionCubit>()
            ..ensureModelDownloaded()
            ..initNotifier(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => sl<AudioCubit>()..initAudio(),
          //..playBackgroundMusic(),
          lazy: false,
        ),

        // Lazy false forces to create the instance instantly
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (previous, current) => previous.locale != current.locale,
        builder: (context, state) => MaterialApp(
          locale: state.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppSupportedLocales.locales,
          debugShowCheckedModeBanner: false,
          title: 'MathScrib',
          theme: AppTheme.light(),
          home: SplashScreen(),
          builder: (context, child) {
            //  Audio listener will work in whole app
            return AudioListener(child: child!);
          },
        ),
      ),
    );
  }
}
