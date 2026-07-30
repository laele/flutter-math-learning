import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_math_app/features/audio/domain/entities/sound_event.dart';
import 'package:flutter_math_app/features/audio/domain/enums/sound_type.dart';
import 'package:flutter_math_app/features/audio/domain/repositories/audio_repository.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  final AudioRepository _audioRepository;
  int _soundEventCounter = 0;
  AudioCubit({required AudioRepository audioRepository}) : _audioRepository = audioRepository, super(const AudioState());

  void _emitNewSoundEvent({required SoundType soundType}) {
    final SoundEvent newSoundEvent = SoundEvent(type: soundType, id: ++_soundEventCounter);
    emit(state.copyWith(soundEvent: newSoundEvent));
  }

  void playSound({required SoundType soundType}) {
    _emitNewSoundEvent(soundType: soundType);
  }

  void initAudio() async {
    await _audioRepository.initAudio();
    emit(state.copyWith(audioLoaded: true));
    //playBackgroundMusic();
  }

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

  void playSfxCorrect() {
    _audioRepository.playSfx(soundSfx: SoundType.correct, volume: 1.0);
  }

  void playSfxIncorrect() {
    _audioRepository.playSfx(soundSfx: SoundType.incorrect, volume: 1.0);
  }

  /*void playBackgroundMusic() {
    _audioRepository.playBackgroundMusic(
      song: BackgroundSongEntity.gameplay,
      volume: 1.0,
    );
  }*/
}
