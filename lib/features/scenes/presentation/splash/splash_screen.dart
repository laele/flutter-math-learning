import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/l10n/arb/app_localizations.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:flutter_math_app/core/widgets/animated_overlay.dart';
import 'package:flutter_math_app/core/widgets/app_filled_button.dart';
import 'package:flutter_math_app/core/widgets/floating_math_symbols_background.dart';
import 'package:flutter_math_app/features/audio/presentation/cubit/audio_cubit.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/cubit/player_profile_cubit.dart';
import 'package:flutter_math_app/features/scenes/presentation/set_player_name/set_player_name_screen.dart';
import 'package:flutter_math_app/features/scenes/presentation/menu/menu_screen.dart';
import 'package:flutter_math_app/features/input_recognition/presentation/input_recognition_cubit/input_recognition_cubit.dart';
import 'package:flutter_math_app/features/scenes/presentation/splash/splash_status_type.dart';
import 'package:flutter_math_app/features/scenes/presentation/splash/splash_cubit/splash_cubit.dart';
import 'package:flutter_math_app/features/settings/presentation/cubit/settings_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => SplashCubit(
        inputRecognitionCubit: context.read<InputRecognitionCubit>(),
        audioCubit: context.read<AudioCubit>(),
        playerProfileCubit: context.read<PlayerProfileCubit>(),
        settingsCubit: context.read<SettingsCubit>(),
      ),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          switch (state.status) {
            case SplashStatus.readyForNewUser:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const SetPlayerNameScreen(),
                ),
              );
            case SplashStatus.readyForExistingUser:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MenuScreen()),
              );
            case SplashStatus.loading:
            case SplashStatus.criticalError:
              break;
          }
        },
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

              Align(
                alignment: AlignmentGeometry.center,
                child: AnimatedOverlay(
                  child: BlocBuilder<SplashCubit, SplashState>(
                    buildWhen: (previous, current) {
                      if (previous.status != current.status) return true;
                      return false;
                    },
                    builder: (context, state) {
                      if (state.status == SplashStatus.loading) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(l10n.loading),
                            SizedBox(height: 8),
                            CircularProgressIndicator(
                              color: Colors.deepOrange,
                            ),
                          ],
                        );
                      } else if (state.status == SplashStatus.criticalError) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            Text(l10n.errorUnknown),
                            AppFilledButton(
                              title: l10n.retry,
                              function: context
                                  .read<SplashCubit>()
                                  .retryInputRecognition,
                            ),
                          ],
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
