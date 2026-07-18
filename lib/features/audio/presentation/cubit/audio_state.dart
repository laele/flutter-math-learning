part of 'audio_cubit.dart';

class AudioState extends Equatable {
  final bool musicMuted;
  final bool sfxMuted;
  final double sfxVolume;
  final double musicVolume;

  const AudioState({
    this.musicMuted = false,
    this.sfxMuted = false,
    this.sfxVolume = 1.0,
    this.musicVolume = 0.6,
  });

  AudioState copyWith({
    bool? musicMuted,
    bool? sfxMuted,
    double? sfxVolume,
    double? musicVolume,
  }) {
    return AudioState(
      musicMuted: musicMuted ?? this.musicMuted,
      sfxMuted: sfxMuted ?? this.sfxMuted,
      musicVolume: musicVolume ?? this.musicVolume,
      sfxVolume: sfxVolume ?? this.sfxVolume,
    );
  }

  @override
  List<Object> get props => [
    musicMuted,
    sfxMuted,
    sfxVolume,
    musicVolume,
  ];
}
