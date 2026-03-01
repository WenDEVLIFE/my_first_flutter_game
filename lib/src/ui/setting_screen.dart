import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/components/glitch_text.dart';
import '../core/components/pixel_button.dart';
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
            const SizedBox(height: 60),
            PixelButton(
              text: 'BACK TO MENU',
              backgroundColor: const Color(0xFFE53935), // Red to match Glitch text
              onPressed: () {
                // Start game logic here
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}