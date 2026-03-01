import 'package:angry_sigma/src/core/background_game.dart';
import 'package:flutter/cupertino.dart';

class GameState extends ChangeNotifier {

  // background game instance
    late BackgroundGame game;

    // start the game
    void startBackgroundGame() {
    game = BackgroundGame(
      assetPath: 'bg/menu.png',
      backgroundMusicPath: 'bg.mp3',
      musicVolume: 0.5,
    );
    notifyListeners();
  }

  // start the game function
  void startGame(){

  }

  // open the settings
  void openSetting(){

  }
}