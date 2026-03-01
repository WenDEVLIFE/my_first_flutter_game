import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal();

  String? _currentBackgroundMusic;
  bool _isInitialized = false;

  /// Initialize audio settings (call this in main or app startup)
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      // Optional: Set default volume
      await FlameAudio.bgm.audioPlayer.setVolume(0.5);
      _isInitialized = true;
      debugPrint('✓ AudioManager initialized successfully');
    } catch (e) {
      debugPrint('✗ Error initializing AudioManager: $e');
    }
  }

  /// Play background music with looping
  /// - [musicPath]: Path to the audio file (e.g., 'sound/menu_music.mp3')
  /// - [volume]: Volume level (0.0 to 1.0), default is 0.5
  Future<void> playBackgroundMusic(
    String musicPath, {
    double volume = 0.5,
  }) async {
    try {
      debugPrint('🎵 Attempting to play: $musicPath (volume: $volume)');

      // Stop current music if playing different track
      if (_currentBackgroundMusic != null && _currentBackgroundMusic != musicPath) {
        debugPrint('⏹️ Stopping previous music: $_currentBackgroundMusic');
        await stopBackgroundMusic();
      }

      _currentBackgroundMusic = musicPath;
      debugPrint('🎵 Starting playback of: $musicPath');

      // Play music with looping enabled
      await FlameAudio.bgm.play(
        musicPath,
        volume: volume,
      );

      debugPrint('✓ Music playing successfully: $musicPath');
    } catch (e) {
      debugPrint('✗ Error playing background music: $e');
      debugPrint('   File path: $musicPath');
      debugPrint('   Make sure the file exists in assets/sound/');
    }
  }

  /// Stop the currently playing background music
  Future<void> stopBackgroundMusic() async {
    try {
      await FlameAudio.bgm.stop();
      _currentBackgroundMusic = null;
    } catch (e) {
      debugPrint('Error stopping background music: $e');
    }
  }

  /// Pause the currently playing background music
  Future<void> pauseBackgroundMusic() async {
    try {
      await FlameAudio.bgm.pause();
    } catch (e) {
      debugPrint('Error pausing background music: $e');
    }
  }

  /// Resume the paused background music
  Future<void> resumeBackgroundMusic() async {
    try {
      await FlameAudio.bgm.resume();
    } catch (e) {
      debugPrint('Error resuming background music: $e');
    }
  }

  /// Set the volume of background music
  /// - [volume]: Volume level (0.0 to 1.0)
  Future<void> setBackgroundMusicVolume(double volume) async {
    try {
      await FlameAudio.bgm.audioPlayer.setVolume(volume);
    } catch (e) {
      debugPrint('Error setting background music volume: $e');
    }
  }

  /// Play a sound effect (non-looping)
  /// - [soundPath]: Path to the audio file (e.g., 'sound/click.mp3')
  /// - [volume]: Volume level (0.0 to 1.0), default is 1.0
  Future<void> playSoundEffect(
    String soundPath, {
    double volume = 1.0,
  }) async {
    try {
      await FlameAudio.play(
        soundPath,
        volume: volume,
      );
    } catch (e) {
      debugPrint('Error playing sound effect: $e');
    }
  }

  /// Check if background music is currently playing
  bool get isBackgroundMusicPlaying => _currentBackgroundMusic != null;

  /// Get the current playing music track
  String? get currentBackgroundMusic => _currentBackgroundMusic;
}
