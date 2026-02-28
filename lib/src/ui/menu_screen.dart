import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../core/background_game.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late final BackgroundGame _game;

  @override
  void initState() {
    super.initState();
    _game = BackgroundGame(assetPath: 'bg/menu.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fullscreen Flame background
          Positioned.fill(
            child: GameWidget(
              game: _game,
              loadingBuilder: (context) => const ColoredBox(
                color: Colors.black,
              ),
            ),
          ),

          // Overlay Flutter UI on top
          Center(
            child: Text(
              'This is the menu screen',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
