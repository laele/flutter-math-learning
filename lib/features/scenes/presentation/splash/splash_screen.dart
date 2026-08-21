import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/l10n/arb/app_localizations.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:flutter_math_app/core/widgets/animated_overlay.dart';
import 'package:flutter_math_app/core/widgets/app_filled_button.dart';
import 'package:flutter_math_app/core/widgets/floating_math_symbols_background.dart';
import 'package:flutter_math_app/features/audio/presentation/cubit/audio_cubit.dart';
import 'package:flutter_math_app/features/input_recognition/domain/enums/input_recognition_error_type.dart';
import 'package:flutter_math_app/features/player_prefs/domain/enums/player_profile_status.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/cubit/player_profile_cubit.dart';
import 'package:flutter_math_app/features/scenes/presentation/set_player_name/set_player_name_screen.dart';
import 'package:flutter_math_app/features/scenes/presentation/menu/menu_screen.dart';
import 'package:flutter_math_app/features/input_recognition/presentation/input_recognition_cubit/input_recognition_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<AnimatedOverlayState> _animatedOverlayKey = GlobalKey<AnimatedOverlayState>();
  bool _hasNavigated = false;
  bool _minDurationElpased = false;

  bool error = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (!mounted) return;
        setState(() {
          _minDurationElpased = true;
          _tryNavigate();
        });
      },
    );
  }

  void _tryNavigate() {
    if (_hasNavigated || !_minDurationElpased) return;

    final audioReady = context.read<AudioCubit>().state.audioLoaded == true;
    final inputReady = context.read<InputRecognitionCubit>().state.isLoaded == true;
    final profileReady = context.read<PlayerProfileCubit>().state.status == PlayerProfileStatus.success;

    if (audioReady && inputReady && profileReady) {
      _hasNavigated = true;
      bool isNewUser =
          context.read<PlayerProfileCubit>().state.profile.bestArcadeScore == 0 && context.read<PlayerProfileCubit>().state.profile.playerName == 'Player';
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => isNewUser ? const SetPlayerNameScreen() : const MenuScreen(),
        ),
      );
    }
  }

  void _showErrorMessage({required String message}) {
    setState(() {
      error = true;
      errorMessage = message;
    });
  }

  String _localizedErrorMessage(BuildContext context, InputRecognitionErrorType type) {
    final l10n = AppLocalizations.of(context)!;
    return switch (type) {
      InputRecognitionErrorType.modelNotDownloaded => l10n.errorModelNotDownloaded,
      _ => l10n.errorUnknown,
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AudioCubit, AudioState>(
          listenWhen: (previous, current) => previous.audioLoaded != current.audioLoaded,
          listener: (context, state) {
            if (state.audioLoaded) {
              _tryNavigate();
            }
          },
        ),
        BlocListener<InputRecognitionCubit, InputRecognitionState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == InputRecognitionStatus.success) {
              _tryNavigate();
            } else if (state.status == InputRecognitionStatus.failed) {
              _showErrorMessage(message: _localizedErrorMessage(context, state.errorType!));
            }
          },
        ),
        BlocListener<PlayerProfileCubit, PlayerProfileState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            _tryNavigate();
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.appSplashBackground,
        body: Stack(
          children: [
            FloatingMathSymbolsBackground(
              color: Colors.white,
              opacity: 0.85,
              symbolCount: 60,
            ),

            Align(
              alignment: AlignmentGeometry.center,
              child: CircularProgressIndicator(
                color: AppColors.iconColor,
              ),
            ),

            error
                ? Align(
                    alignment: AlignmentGeometry.center,
                    child: AnimatedOverlay(
                      key: _animatedOverlayKey,
                      child: Column(
                        children: [
                          Text(errorMessage!),
                          AppFilledButton(
                            title: 'Retry',
                            function: () async {
                              await _animatedOverlayKey.currentState?.playOutAnimation();
                              ();
                              if (!mounted) return;
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const SplashScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
