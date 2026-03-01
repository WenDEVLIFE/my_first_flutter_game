import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/components/glitch_text.dart';
import '../core/components/pixel_button.dart';
import '../core/states/game_state.dart';
import 'levels/level_1_screen.dart';
import 'levels/level_2_screen.dart';
import 'levels/level_3_screen.dart';
import 'levels/level_4_screen.dart';
import 'levels/level_5_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const GlitchText(
              text: 'SELECT LEVEL',
              fontSize: 50,
              color: Colors.red,
            ),
            const SizedBox(height: 60),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: List.generate(5, (index) {
                final level = index + 1;
                return Consumer<GameState>(
                  builder: (context, gameState, child) {
                    final isUnlocked = level <= gameState.maxUnlockedLevel;
                    return _LevelButton(
                      level: level,
                      isUnlocked: isUnlocked,
                      onPressed: isUnlocked
                          ? () {
                              gameState.selectLevel(level);
                              
                              Widget screen;
                              switch (level) {
                                case 1: screen = const Level1Screen(); break;
                                case 2: screen = const Level2Screen(); break;
                                case 3: screen = const Level3Screen(); break;
                                case 4: screen = const Level4Screen(); break;
                                case 5: screen = const Level5Screen(); break;
                                default: screen = const Level1Screen();
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => screen,
                                ),
                              );
                            }
                          : null,
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 60),
            PixelButton(
              text: 'BACK TO MENU',
              backgroundColor: const Color(0xFFE53935),
              onPressed: () {
                context.read<GameState>().startButtonEff();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelButton extends StatelessWidget {
  final int level;
  final bool isUnlocked;
  final VoidCallback? onPressed;

  const _LevelButton({
    required this.level,
    required this.isUnlocked,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: isUnlocked ? const Color(0xFF1E88E5) : Colors.grey[800],
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Center(
          child: isUnlocked
              ? Text(
                  '$level',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'PixelFont',
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 32,
                ),
        ),
      ),
    );
  }
}
