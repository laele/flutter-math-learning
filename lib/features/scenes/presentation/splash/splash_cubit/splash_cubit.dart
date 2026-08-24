import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/features/audio/presentation/cubit/audio_cubit.dart';
import 'package:flutter_math_app/features/input_recognition/domain/enums/input_recognition_error_type.dart';
import 'package:flutter_math_app/features/input_recognition/presentation/input_recognition_cubit/input_recognition_cubit.dart';
import 'package:flutter_math_app/features/player_prefs/domain/enums/player_profile_status.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/cubit/player_profile_cubit.dart';
import 'package:flutter_math_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter_math_app/features/scenes/presentation/splash/splash_status_type.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final InputRecognitionCubit _inputRecognitionCubit;
  final AudioCubit _audioCubit;
  final PlayerProfileCubit _playerProfileCubit;
  final SettingsCubit _settingsCubit;

  StreamSubscription? _inputSub;
  StreamSubscription? _audioSub;
  StreamSubscription? _profileSub;
  StreamSubscription? _settingsSub;

  static const _minSplashDuration = Duration(seconds: 2);
  bool _minDurationElpased = false;
  bool _nonCriticalReady = false;

  SplashCubit({
    required InputRecognitionCubit inputRecognitionCubit,
    required AudioCubit audioCubit,
    required PlayerProfileCubit playerProfileCubit,
    required SettingsCubit settingsCubit,
  }) : _inputRecognitionCubit = inputRecognitionCubit,
       _audioCubit = audioCubit,
       _playerProfileCubit = playerProfileCubit,
       _settingsCubit = settingsCubit,
       super(SplashState()) {
    _subscribeTosources();
  }

  void _subscribeTosources() {
    // critical  - input_recognition must work
    _inputSub = _inputRecognitionCubit.stream.listen(
      _onInputRecognitionChanged,
    );
    // non critical features
    _audioSub = _audioCubit.stream.listen((_) => _checkNonCriticalReady());
    _profileSub = _playerProfileCubit.stream.listen(
      (_) => _checkNonCriticalReady(),
    );
    _settingsSub = _settingsCubit.stream.listen(
      (_) => _checkNonCriticalReady(),
    );

    Future.delayed(_minSplashDuration, () {
      _minDurationElpased = true;
      _tryComplete();
    });

    // check current state if subs were already completed before
    _onInputRecognitionChanged(_inputRecognitionCubit.state);
    _checkNonCriticalReady();
  }

  void _onInputRecognitionChanged(InputRecognitionState state) {
    if (state.status == InputRecognitionStatus.failed) {
      emit(
        SplashState(
          status: SplashStatus.criticalError,
          errorType: state.errorType,
        ),
      );
      return;
    }

    if (state.status == InputRecognitionStatus.success && state.isLoaded) {
      _tryComplete();
    }
  }

  void _tryComplete() {
    if (state.status == SplashStatus.criticalError) return;
    if (!_minDurationElpased) return;
    if (_inputRecognitionCubit.state.status != InputRecognitionStatus.success)
      return;
    if (!_nonCriticalReady) return;

    final profile = _playerProfileCubit.state.profile;
    final isNewUser =
        profile.bestArcadeScore == 0 && profile.playerName == 'Player';

    emit(
      SplashState(
        status: isNewUser
            ? SplashStatus.readyForNewUser
            : SplashStatus.readyForExistingUser,
      ),
    );
  }

  void retryInputRecognition() {
    emit(const SplashState(status: SplashStatus.loading));
    _inputRecognitionCubit.retry();
  }

  void _checkNonCriticalReady() {
    final audioSettled =
        _audioCubit.state.audioLoaded || _audioCubit.state.hasError;
    final profileSettled =
        _playerProfileCubit.state.status == PlayerProfileStatus.success ||
        _playerProfileCubit == PlayerProfileStatus.error;
    final settingsSettled = _settingsCubit.state.isLoaded;

    _nonCriticalReady = audioSettled && profileSettled && settingsSettled;
    if (_nonCriticalReady) _tryComplete();
  }

  Future<void> close() {
    _inputSub?.cancel();
    _audioSub?.cancel();
    _profileSub?.cancel();
    _settingsSub?.cancel();
    return super.close();
  }
}
