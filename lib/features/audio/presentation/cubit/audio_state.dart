part of 'audio_cubit.dart';

class AudioState extends Equatable {
  final bool audioLoaded;
  final bool musicMuted;
  final bool sfxMuted;
  final double sfxVolume;
  final double musicVolume;

  const AudioState({
    this.audioLoaded = false,
    this.musicMuted = false,
    this.sfxMuted = false,
    this.sfxVolume = 1.0,
    this.musicVolume = 0.6,
  });

  AudioState copyWith({
    bool? audioLoaded,
    bool? musicMuted,
    bool? sfxMuted,
    double? sfxVolume,
    double? musicVolume,
  }) {
    return AudioState(
      audioLoaded: audioLoaded ?? this.audioLoaded,
      musicMuted: musicMuted ?? this.musicMuted,
      sfxMuted: sfxMuted ?? this.sfxMuted,
      musicVolume: musicVolume ?? this.musicVolume,
      sfxVolume: sfxVolume ?? this.sfxVolume,
    );
  }

  @override
  List<Object> get props => [
    audioLoaded,
    musicMuted,
    sfxMuted,
    sfxVolume,
    musicVolume,
  ];
}
