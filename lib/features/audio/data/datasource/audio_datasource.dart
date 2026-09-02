import 'package:flutter_math_app/features/audio/domain/enums/song_type.dart';
import 'package:flutter_math_app/features/audio/domain/enums/sound_type.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

abstract interface class AudioDataSource {
  Future<void> init();
  Future<void> playSfx({required SoundType effect, required double volume});
  Future<void> playMusic({required SongType song, required double volume});
  Future<void> stopMusic();
  Future<void> pauseMusic();
  Future<void> resumeMusic();

  Future<void> dispose();
}

class AudioDataSourceImpl implements AudioDataSource {
  final SoLoud _soloud = SoLoud.instance;
  SoundHandle? _musicHandle;

  final Map<SongType, AudioSource> _songs = {};
  final Map<SoundType, AudioSource> _sfx = {};

  static const _songsAssets = {
    //SongType.gameplay: 'assets/music/background_song.mp3',
  };
  static const _sfxAssets = {
    SoundType.correct: 'assets/sfx/correct_sound_2.mp3',
    SoundType.incorrect: 'assets/sfx/error_sound.mp3',
  };
  @override
  Future<void> init() async {
    await _soloud.init();
    await _preloadAssets();
  }

  Future<void> _preloadAssets() async {
    for (final entry in _songsAssets.entries) {
      _songs[entry.key] = await _soloud.loadAsset(entry.value); // load song
    }

    for (final entry in _sfxAssets.entries) {
      _sfx[entry.key] = await _soloud.loadAsset(entry.value); // load sfx
    }
  }

  @override
  Future<void> playSfx({required SoundType effect, required double volume}) async {
    final source = _sfx[effect];
    if (source == null) return;
    _soloud.play(source, volume: volume);
  }

  @override
  Future<void> playMusic({required SongType song, required double volume}) async {
    final source = _songs[song];
    if (source == null) return;
    if (_musicHandle != null) {
      await stopMusic();
    }
    _musicHandle = _soloud.play(source!, looping: true, volume: volume);
  }

  @override
  Future<void> pauseMusic() async {
    if (_musicHandle == null) return;
    _soloud.setPause(_musicHandle!, true);
  }

  @override
  Future<void> resumeMusic() async {
    if (_musicHandle == null) return;
    _soloud.setPause(_musicHandle!, false);
  }

  @override
  Future<void> stopMusic() async {
    if (_musicHandle == null) return;
    _soloud.stop(_musicHandle!);
    _musicHandle = null;
  }

  @override
  Future<void> dispose() async {
    await _soloud.disposeAllSources();
  }
}
