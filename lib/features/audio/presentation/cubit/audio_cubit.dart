import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/features/audio/domain/entities/background_track_entity.dart';
import 'package:flutter_math_app/features/audio/domain/entities/sound_effect_entity.dart';
import 'package:flutter_math_app/features/audio/domain/repositories/audio_repository.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  final AudioRepository _audioRepository;
  AudioCubit({required AudioRepository audioRepository}) : _audioRepository = audioRepository, super(const AudioState());

  void toggleSfxMute() {
    final sfxMuted = !state.sfxMuted;
    _audioRepository.setSfxMuted(muted: sfxMuted);
    emit(state.copyWith(sfxMuted: sfxMuted));
  }

  void toggleMusicMute() {
    final musicMuted = !state.musicMuted;
    _audioRepository.setTrackMuted(muted: musicMuted);
    emit(state.copyWith(musicMuted: musicMuted));
  }

  void setMusicVolume(double volume) {
    _audioRepository.setMusicVolume(volume: volume);
    emit(state.copyWith(musicVolume: volume));
  }

  void playSfxButtonTap() {
    _audioRepository.playSfx(soundSfx: SoundEffectEntity.buttonTap);
  }

  void playSfxCorrect() {
    _audioRepository.playSfx(soundSfx: SoundEffectEntity.correct);
  }

  void playSfxIncorrect() {
    _audioRepository.playSfx(soundSfx: SoundEffectEntity.incorrect);
  }

  void playBackgroundMusic() {
    print('song');
    _audioRepository.playBackgroundMusic(track: BackgroundTrackEntity.gameplay);
  }
}
