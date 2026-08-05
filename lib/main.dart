import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/di/init_dependencies.dart';
import 'package:flutter_math_app/core/theme/app_theme.dart';
import 'package:flutter_math_app/features/audio/presentation/cubit/audio_cubit.dart';
import 'package:flutter_math_app/features/audio/presentation/widgets/audio_listener.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/cubit/player_profile_cubit.dart';
import 'package:flutter_math_app/features/scenes/presentation/splash/splash_screen.dart';
import 'package:flutter_math_app/features/input_recognition/presentation/input_recognition_cubit/input_recognition_cubit.dart';
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
          create: (context) => sl<PlayerProfileCubit>()..loadProfile(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => sl<InputRecognitionCubit>()
            ..ensureModelDownloaded()
            ..initNotifier(),
        ),
        BlocProvider(
          create: (context) => sl<AudioCubit>()..initAudio(),
          //..playBackgroundMusic(),
          lazy: false,
        ),
        // Lazy false forces to create the instance instantly
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Froggy Math',
        theme: AppTheme.light(),
        home: SplashScreen(),
        builder: (context, child) {
          //  Audio listener will work in whole app
          return AudioListener(child: child!);
        },
      ),
    );
  }
}
