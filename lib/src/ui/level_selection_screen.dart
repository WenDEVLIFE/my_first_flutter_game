import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/components/glitch_text.dart';
import '../core/components/pixel_button.dart';
import '../core/states/game_state.dart';

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
                              // For now just pop back to menu
                              Navigator.pop(context);
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
