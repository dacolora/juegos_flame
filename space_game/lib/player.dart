import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import 'game.dart';

class Player extends SpriteAnimationComponent with HasGameRef<SpaceGame> {
  Images images;
  late final SpriteAnimation _standing;
  late final _animationSpeed = 0.15;

  Player(this.images) : super(size: Vector2.all(32)) {
    add(RectangleHitbox());
  }

  @override
  Future<void>? onLoad() async {
    await _loadAnimations().then((_) => {animation = _standing});
    return super.onLoad();
  }

  Future<void> _loadAnimations() async {
    final sprite = SpriteSheet(
      image: images.fromCache('player_spritesheet.png'),
      srcSize: Vector2(29.0, 32.0),
    );

    _standing =
        sprite.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    x = size.x / 3;
    y = size.y / 3;
    super.onGameResize(size);
  }
}
