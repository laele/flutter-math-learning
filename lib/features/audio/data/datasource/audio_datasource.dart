import 'package:flutter_math_app/features/audio/domain/entities/sound_effect_entity.dart';
import 'package:audioplayers/audioplayers.dart';

abstract interface class AudioDataSource {
  Future<void> preloadSfx();
  Future<void> playSfx({required SoundEffectEntity effect, required double volume, required bool muted});
  Future<void> playMusic({required String trackPath, required double volume, required bool muted});
  Future<void> stopMusic();
  Future<void> pauseMusic();
  Future<void> resumeMusic();

  Future<void> dispose();
}

class AudioDataSourceImpl implements AudioDataSource {
  AudioDataSourceImpl() {
    AudioCache.instance = AudioCache(prefix: '');
  }

  final Map<SoundEffectEntity, AudioPool> _pools = {};
  final AudioPlayer _musicPlayer = AudioPlayer();

  static const _sfxAssets = {
    SoundEffectEntity.correct: 'lib/core/assets/sfx/correct_sound.mp3',
    SoundEffectEntity.incorrect: 'lib/core/assets/sfx/error_sound.mp3',
    SoundEffectEntity.buttonTap: 'lib/core/assets/sfx/button_tap.mp3',
  };

  @override
  Future<void> preloadSfx() async {
    for (final entry in _sfxAssets.entries) {
      _pools[entry.key] = await AudioPool.createFromAsset(path: '${entry.value}', maxPlayers: 3);
    }
  }

  @override
  Future<void> pauseMusic() => _musicPlayer.stop();

  @override
  Future<void> resumeMusic() => _musicPlayer.resume();

  @override
  Future<void> stopMusic() => _musicPlayer.stop();

  @override
  Future<void> playMusic({required String trackPath, required double volume, required bool muted}) async {
    await _musicPlayer.stop();
    await _musicPlayer.setReleaseMode(ReleaseMode.loop);
    await _musicPlayer.setVolume(muted ? 0.0 : volume);
    await _musicPlayer.play(AssetSource(trackPath));
  }

  @override
  Future<void> playSfx({required SoundEffectEntity effect, required double volume, required bool muted}) async {
    if (muted) return;
    final pool = _pools[effect];
    if (pool == null) return;
    await pool.start(volume: volume);
  }

  @override
  Future<void> dispose() async {
    for (final pool in _pools.values) {
      await pool.dispose();
    }
    await _musicPlayer.dispose();
  }
}
