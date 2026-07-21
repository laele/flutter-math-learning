import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/features/audio/presentation/cubit/audio_cubit.dart';
import 'package:flutter_math_app/features/game/presentation/screens/home/home_screen.dart';
import 'package:flutter_math_app/features/input_recognition/presentation/input_recognition_cubit/input_recognition_cubit.dart';

class HomeSplash extends StatefulWidget {
  const HomeSplash({super.key});

  @override
  State<HomeSplash> createState() => _HomeSplashState();
}

class _HomeSplashState extends State<HomeSplash> {
  bool audioLoaded = false;
  bool inputRecognizerLoaded = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AudioCubit, AudioState>(
      listenWhen: (previous, current) => previous.audioLoaded != current.audioLoaded,
      listener: (context, state) {
        if (state.audioLoaded) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  color: Colors.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Loaded Audio: ${context.read<AudioCubit>().state.audioLoaded}'),
                      SizedBox(height: 4.0),
                      Text('Loaded Input Recognizer: ${context.read<InputRecognitionCubit>().state.isLoaded}'),
                      SizedBox(height: 8.0),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
