
import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class BackgroundGame extends FlameGame {
  final String assetPath;

  BackgroundGame({required this.assetPath});

  final SpriteComponent _bg = SpriteComponent()..anchor = Anchor.center;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final image = await images.load(assetPath);
    _bg.sprite = Sprite(image);
    add(_bg);
    // ensure correct sizing immediately after load
    _updateBgForSize(size);
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