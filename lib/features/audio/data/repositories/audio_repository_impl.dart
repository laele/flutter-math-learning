import 'package:flutter_math_app/features/audio/data/datasource/audio_datasource.dart';
import 'package:flutter_math_app/features/audio/domain/entities/background_track_entity.dart';
import 'package:flutter_math_app/features/audio/domain/entities/sound_effect_entity.dart';
import 'package:flutter_math_app/features/audio/domain/repositories/audio_repository.dart';

class AudioRepositoryImpl implements AudioRepository {
  final AudioDataSource _datasource;
  AudioRepositoryImpl({required AudioDataSource datasource}) : _datasource = datasource;

  double _sfxVolume = 1.0;
  double _musicVolume = 0.6;

  bool _mutedMusic = false;
  bool _mutedSfx = false;

  static const _trackPaths = {};

  Future<void> init() => _datasource.preloadSfx();

  @override
  Future<void> playBackgroundMusic({required BackgroundTrackEntity track}) async {
    final asset = _trackPaths[track];
    if (asset == null) return Future.value();
    return _datasource.playMusic(trackPath: asset, volume: _musicVolume, muted: _mutedMusic);
  }

  @override
  Future<void> playSfx({required SoundEffectEntity soundSfx}) {
    return _datasource.playSfx(effect: soundSfx, volume: _sfxVolume, muted: _mutedSfx);
  }

  @override
  Future<void> setMusicVolume({required double volume}) async {
    _musicVolume = volume.clamp(0.0, 1.0);
  }

  @override
  Future<void> setSfxVolume({required double volume}) async {
    _sfxVolume = volume.clamp(0.0, 1.0);
  }

  @override
  Future<void> setSfxMuted({required bool muted}) async {
    _mutedSfx = muted;
  }

  @override
  Future<void> setTrackMuted({required bool muted}) async {
    _mutedMusic = muted;
    if (_mutedMusic) {
      await _datasource.pauseMusic();
    } else {
      await _datasource.resumeMusic();
    }
  }

  @override
  Future<void> pauseBackgroundMusic() => _datasource.pauseMusic();

  @override
  Future<void> resumeBackgroundMusic() => _datasource.resumeMusic();

  @override
  Future<void> stopBackgroundMusic() => _datasource.stopMusic();

  @override
  Future<void> dispose() => _datasource.dispose();
}
