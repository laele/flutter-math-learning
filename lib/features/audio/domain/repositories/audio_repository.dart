import 'package:flutter_math_app/features/audio/domain/entities/background_track_entity.dart';
import 'package:flutter_math_app/features/audio/domain/entities/sound_effect_entity.dart';

abstract interface class AudioRepository {
  Future<void> playSfx({required SoundEffectEntity soundSfx});
  Future<void> playBackgroundMusic({required BackgroundTrackEntity track});
  Future<void> stopBackgroundMusic();
  Future<void> pauseBackgroundMusic();
  Future<void> resumeBackgroundMusic();

  Future<void> setSfxVolume({required double volume});
  Future<void> setMusicVolume({required double volume});
  Future<void> setSfxMuted({required bool muted});
  Future<void> setTrackMuted({required bool muted});

  Future<void> dispose();
}
