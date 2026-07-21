import 'package:dartz/dartz.dart';
import 'package:flutter_math_app/features/audio/domain/entities/background_song_entity.dart';
import 'package:flutter_math_app/features/audio/domain/entities/sound_effect_entity.dart';

abstract interface class AudioRepository {
  Future<Unit> initAudio();
  Future<void> playSfx({required SoundEffectEntity soundSfx, required double volume});
  Future<void> playBackgroundMusic({required BackgroundSongEntity song, required double volume});
  Future<void> stopBackgroundMusic();
  Future<void> pauseBackgroundMusic();
  Future<void> resumeBackgroundMusic();

  Future<void> setSfxVolume({required double volume});
  Future<void> setMusicVolume({required double volume});
  Future<void> setSfxMuted({required bool muted});
  Future<void> setTrackMuted({required bool muted});

  Future<void> dispose();
}
