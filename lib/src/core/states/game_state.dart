import 'package:angry_sigma/src/core/background_game.dart';
import 'package:angry_sigma/src/core/services/audio_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameState extends ChangeNotifier {

  // background game instance
    late BackgroundGame game;

    double _volume = 0.5;
    bool _isMuted = false;
    int _currentLevel = 1;
    int _maxUnlockedLevel = 1;
    bool _isInLevel = false;

    static const String _volumeKey = 'audio_volume';
    static const String _muteKey = 'audio_muted';

    double get volume => _volume;
    bool get isMuted => _isMuted;
    int get currentLevel => _currentLevel;
    int get maxUnlockedLevel => _maxUnlockedLevel;
    bool get isInLevel => _isInLevel;

    GameState() {
      _loadSettings();
    }

    Future<void> _loadSettings() async {
      final prefs = await SharedPreferences.getInstance();
      _volume = prefs.getDouble(_volumeKey) ?? 0.5;
      _isMuted = prefs.getBool(_muteKey) ?? false;
      
      // Apply initial settings
      if (_isMuted) {
        await AudioManager().setBackgroundMusicVolume(0);
      } else {
        await AudioManager().setBackgroundMusicVolume(_volume);
      }
      notifyListeners();
    }

    Future<void> _saveSettings() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_volumeKey, _volume);
      await prefs.setBool(_muteKey, _isMuted);
    }

    // start the game
    void startBackgroundGame() {
    _isInLevel = false;
    game = BackgroundGame(
      assetPath: 'bg/menu.png',
      backgroundMusicPath: 'bg.mp3',
      musicVolume: _isMuted ? 0.0 : _volume,
    );
    notifyListeners();
  }

  // start the game function
  void startButtonEff(){
    AudioManager().playSoundEffect('btn_sound.mp3', volume: _isMuted ? 0.0 : 0.7);
    notifyListeners();
  }


  void setVolume(double value) {
    _volume = value;
    if (!_isMuted) {
      AudioManager().setBackgroundMusicVolume(_volume);
    }
    _saveSettings();
    notifyListeners();
  }

  void toggleMute() {
    _isMuted = !_isMuted;
    if (_isMuted) {
      AudioManager().setBackgroundMusicVolume(0);
    } else {
      AudioManager().setBackgroundMusicVolume(_volume);
    }
    _saveSettings();
    notifyListeners();
  }

  void selectLevel(int level) {
    if (level <= _maxUnlockedLevel) {
      _currentLevel = level;
      _isInLevel = true;
      
      // Update background for the selected level
      game = BackgroundGame(
        assetPath: 'bg/lvl$level.png',
        backgroundMusicPath: 'bg.mp3',
        musicVolume: _isMuted ? 0.0 : _volume,
      );
      
      startButtonEff();
      notifyListeners();
    }
  }

  void unlockNextLevel() {
    if (_currentLevel == _maxUnlockedLevel && _maxUnlockedLevel < 5) {
      _maxUnlockedLevel++;
      notifyListeners();
    }
  }
}