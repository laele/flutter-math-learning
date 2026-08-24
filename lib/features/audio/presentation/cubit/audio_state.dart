part of 'audio_cubit.dart';

class AudioState extends Equatable {
  final bool audioLoaded;
  final bool hasError;
  final bool musicMuted;
  final bool sfxMuted;
  final double sfxVolume;
  final double musicVolume;

  final SoundEvent? soundEvent;

  const AudioState({
    this.soundEvent,
    this.audioLoaded = false,
    this.musicMuted = false,
    this.sfxMuted = false,
    this.sfxVolume = 1.0,
    this.musicVolume = 0.6,
    this.hasError = false,
  });

  AudioState copyWith({
    bool? audioLoaded,
    bool? musicMuted,
    bool? sfxMuted,
    double? sfxVolume,
    double? musicVolume,
    SoundEvent? soundEvent,
    bool? hasError,
  }) {
    return AudioState(
      hasError: hasError ?? this.hasError,
      soundEvent: soundEvent ?? this.soundEvent,
      audioLoaded: audioLoaded ?? this.audioLoaded,
      musicMuted: musicMuted ?? this.musicMuted,
      sfxMuted: sfxMuted ?? this.sfxMuted,
      musicVolume: musicVolume ?? this.musicVolume,
      sfxVolume: sfxVolume ?? this.sfxVolume,
    );
  }

  @override
  List<Object?> get props => [
    soundEvent,
    audioLoaded,
    musicMuted,
    sfxMuted,
    sfxVolume,
    musicVolume,
    hasError,
  ];
}
