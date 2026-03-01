import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/components/glitch_text.dart';
import '../core/components/pixel_button.dart';
import '../core/components/pixel_slider.dart';
import '../core/components/pixel_mute_button.dart';
import '../core/states/game_state.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const GlitchText(
              text: 'SETTINGS',
              fontSize: 50,
              color: Colors.red,
            ),
            const SizedBox(height: 40),
            // Volume Control Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Consumer<GameState>(
                builder: (context, gameState, child) {
                  return Column(
                    children: [
                      GlitchText(
                        text: 'VOLUME',
                        fontSize: 25,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          PixelMuteButton(
                            isMuted: gameState.isMuted,
                            onTap: gameState.toggleMute,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: PixelSlider(
                              value: gameState.volume,
                              onChanged: gameState.setVolume,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            PixelButton(
              text: 'BACK TO MENU',
              backgroundColor: const Color(0xFFE53935), // Red to match Glitch text
              onPressed: () {
                // Start game logic here
                Navigator.pop(context);
                context.read<GameState>().startButtonEff();
              },
            ),
          ],
        ),
      ),
    );
  }
}