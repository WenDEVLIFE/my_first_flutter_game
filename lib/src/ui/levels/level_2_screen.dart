import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:provider/provider.dart';
import '../../core/states/game_state.dart';
import '../../core/components/glitch_text.dart';
import '../../core/components/pixel_button.dart';

class Level2Screen extends StatelessWidget {
  const Level2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Consumer<GameState>(
              builder: (context, gameState, child) {
                return GameWidget(
                  game: gameState.game,
                  loadingBuilder: (context) => const ColoredBox(
                    color: Colors.black,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const GlitchText(
                        text: 'LEVEL 2',
                        fontSize: 30,
                        color: Colors.blue,
                      ),
                      PixelButton(
                        text: 'MENU',
                        backgroundColor: Colors.red,
                        onPressed: () {
                          context.read<GameState>().startButtonEff();
                          context.read<GameState>().startBackgroundGame();
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
