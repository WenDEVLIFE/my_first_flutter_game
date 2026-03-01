
import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'services/audio_manager.dart';

class BackgroundGame extends FlameGame {
  final String assetPath;
  final String? backgroundMusicPath;
  final double musicVolume;

  BackgroundGame({
    required this.assetPath,
    this.backgroundMusicPath,
    this.musicVolume = 0.5,
  });

  final SpriteComponent _bg = SpriteComponent()..anchor = Anchor.center;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugPrint('🎮 BackgroundGame onLoad() started');

    final image = await images.load(assetPath);
    _bg.sprite = Sprite(image);
    add(_bg);
    // ensure correct sizing immediately after load
    _updateBgForSize(size);

    debugPrint('🎮 Background image loaded: $assetPath');

    // Initialize and play background music if provided
    if (backgroundMusicPath != null) {
      try {
        debugPrint('🎵 Initializing AudioManager...');
        await AudioManager().init();

        debugPrint('🎵 Playing background music: $backgroundMusicPath');
        await AudioManager().playBackgroundMusic(
          backgroundMusicPath!,
          volume: musicVolume,
        );
      } catch (e) {
        debugPrint('✗ Error with audio playback: $e');
      }
    } else {
      debugPrint('⚠️ No background music path provided');
    }

    debugPrint('🎮 BackgroundGame onLoad() completed');
  }

  @override
  void onRemove() {
    // Stop music when game is removed
    AudioManager().stopBackgroundMusic();
    super.onRemove();
  }

  @override
  void onGameResize(Vector2 newSize) {
    super.onGameResize(newSize);
    if (_bg.sprite == null) return;
    _updateBgForSize(newSize);
  }

  void _updateBgForSize(Vector2 gameSize) {
    final img = _bg.sprite?.image;
    if (img == null) {
      _bg.size = gameSize;
      _bg.position = gameSize / 2;
      return;
    }

    final orig = Vector2(img.width.toDouble(), img.height.toDouble());
    final scale = math.max(gameSize.x / orig.x, gameSize.y / orig.y);
    _bg.size = orig * scale; // fills canvas, may overflow and be cropped
    _bg.position = gameSize / 2; // exact center
  }
}