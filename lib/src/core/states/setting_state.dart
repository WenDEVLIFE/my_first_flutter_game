import 'package:flutter/cupertino.dart';

import '../background_game.dart';

class SettingState extends ChangeNotifier {

  // background game instance
  late BackgroundGame widgetGame;

  // start the game
  void startBackgroundGame() {
    widgetGame = BackgroundGame(
      assetPath: 'bg/menu.png',
    );
    notifyListeners();
  }

  // open the settings
  void adjustVolume(){

  }

  // change theme of the menu screen and setting screen
  void changeTheme(){

  }


}