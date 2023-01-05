import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class CarBackGround extends SpriteAnimationComponent with CollisionCallbacks {
  final Images images;
  final double positionInitialX;
  final double positionInitialY;
  final Vector2 tamano;

  late double widthPhone;
  late final SpriteAnimation _standingAnimation;
  final double _animationSpeed = 0.15;
  CarBackGround({
    required this.images,
    required this.tamano,
    required this.positionInitialX,
    required this.positionInitialY,
  }) : super(
          size: Vector2(tamano.x / 2 + tamano.x / 4, tamano.y / 3),
        ) {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    await _loadAnimations().then((_) => {animation = _standingAnimation});
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: images.fromCache('green.png'),
      srcSize: Vector2(88, 68),
    );

    _standingAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
  }

  @override
  void onGameResize(Vector2 size) {
    x = positionInitialX; //24000
    y = positionInitialY; //24000
    widthPhone = size.x * 2;
    super.onGameResize(size);
  }
}
