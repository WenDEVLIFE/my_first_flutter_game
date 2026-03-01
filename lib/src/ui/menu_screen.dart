import 'package:angry_sigma/src/core/states/game_state.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/background_game.dart';
import '../core/components/glitch_text.dart';
import '../core/components/pixel_button.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {


  @override
  void initState() {
    super.initState();

    context.read<GameState>().startBackgroundGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fullscreen Flame background
          Positioned.fill(
            child: GameWidget(
              game:  context.watch<GameState>().game,
              loadingBuilder: (context) => const ColoredBox(
                color: Colors.black,
              ),
            ),
          ),

          // Overlay Flutter UI on top
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const GlitchText(
                  text: 'ANGRY SIGMA',
                  fontSize: 50,
                  color: Colors.red,
                ),
                const SizedBox(height: 60),
                PixelButton(
                  text: 'START GAME',
                  backgroundColor: const Color(0xFFE53935), // Red to match Glitch text
                  onPressed: () {
                    // Start game logic here
                  },
                ),
                const SizedBox(height: 20),
                PixelButton(
                  text: '   SETTINGS  ',
                  backgroundColor: const Color(0xFF1E88E5),
                  onPressed: () {
                    // Settings logic here
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
