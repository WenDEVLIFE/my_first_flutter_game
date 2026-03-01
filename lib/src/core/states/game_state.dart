import 'package:angry_sigma/src/core/background_game.dart';
import 'package:angry_sigma/src/core/services/audio_manager.dart';
import 'package:flutter/cupertino.dart';

class GameState extends ChangeNotifier {

  // background game instance
    late BackgroundGame game;

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
    AudioManager().playSoundEffect('btn_sound.mp3', volume: 0.7);
    notifyListeners();
  }
}