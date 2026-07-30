import 'package:dartz/dartz.dart';
import 'package:flutter_math_app/features/audio/domain/enums/sound_type.dart';
import 'package:flutter_math_app/features/audio/domain/enums/song_type.dart';

abstract interface class AudioRepository {
  Future<Unit> initAudio();
  Future<void> playSfx({required SoundType soundSfx, required double volume});
  Future<void> playBackgroundMusic({required SongType song, required double volume});
  Future<void> stopBackgroundMusic();
  Future<void> pauseBackgroundMusic();
  Future<void> resumeBackgroundMusic();

  Future<void> setSfxVolume({required double volume});
  Future<void> setMusicVolume({required double volume});
  Future<void> setSfxMuted({required bool muted});
  Future<void> setTrackMuted({required bool muted});

  Future<void> dispose();
}
