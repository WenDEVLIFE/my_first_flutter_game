import 'package:angry_sigma/src/core/states/game_state.dart';
import 'package:angry_sigma/src/ui/level_selection_screen.dart';
import 'package:angry_sigma/src/ui/setting_screen.dart';
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
  bool _showUI = true;

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
          if (!context.watch<GameState>().isInLevel)
          Positioned.fill(
            child: GameWidget(
              game:  context.watch<GameState>().game,
              loadingBuilder: (context) => const ColoredBox(
                color: Colors.black,
              ),
            ),
          ),

          // Overlay Flutter UI on top
          AnimatedOpacity(
            opacity: _showUI ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Center(
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
                  onPressed: () async {
                    // Settings logic here
                    context.read<GameState>().startButtonEff();
                    setState(() {
                      _showUI = false;
                    });
                    await Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, _, __) => const LevelSelectionScreen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                    if (mounted) {
                      setState(() {
                        _showUI = true;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                PixelButton(
                  text: '   SETTINGS  ',
                  backgroundColor: const Color(0xFF1E88E5),
                  onPressed: () async {
                    // Settings logic here
                    context.read<GameState>().startButtonEff();
                    setState(() {
                      _showUI = false;
                    });
                    await Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, _, __) => const SettingScreen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                    if (mounted) {
                      setState(() {
                        _showUI = true;
                      });
                    }
                  },
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
