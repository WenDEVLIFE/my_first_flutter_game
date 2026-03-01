import 'package:angry_sigma/src/core/background_game.dart';
import 'package:angry_sigma/src/core/services/audio_manager.dart';
import 'package:flutter/cupertino.dart';

class GameState extends ChangeNotifier {

  // background game instance
    late BackgroundGame game;

    double _volume = 0.5;
    bool _isMuted = false;

    double get volume => _volume;
    bool get isMuted => _isMuted;

    GameState() {
      // Sync initial volume
      AudioManager().setBackgroundMusicVolume(_volume);
    }

    // start the game
    void startBackgroundGame() {
    game = BackgroundGame(
      assetPath: 'bg/menu.png',
      backgroundMusicPath: 'bg.mp3',
      musicVolume: 0.1,
    );
    notifyListeners();
  }

  // start the game function
  void startGame(){
    AudioManager().playSoundEffect('btn_sound.mp3', volume: 0.7);
    notifyListeners();
  }

  // open the settings
  void openSetting(){
    AudioManager().playSoundEffect('btn_sound.mp3', volume: _isMuted ? 0 : 0.7);
    notifyListeners();
  }

  void setVolume(double value) {
    _volume = value;
    if (!_isMuted) {
      AudioManager().setBackgroundMusicVolume(_volume);
    }
    notifyListeners();
  }

  void toggleMute() {
    _isMuted = !_isMuted;
    if (_isMuted) {
      AudioManager().setBackgroundMusicVolume(0);
    } else {
      AudioManager().setBackgroundMusicVolume(_volume);
    }
    notifyListeners();
  }
}