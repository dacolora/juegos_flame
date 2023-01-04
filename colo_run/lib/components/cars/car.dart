import 'package:colo_run/components/cars/backGroundColiision.dart';
import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Car extends SpriteAnimationComponent {
  final Images images;
  final String imageRoute;
  final Vector2 tamano;
  final double positionInitialX;
  final double positionInitialY;
  final Vector2 pixelsImage;

  late double widthPhone;
  late final SpriteAnimation _standingAnimation;
  final double _animationSpeed = 0.15;
  Car({
    required this.images,
    required this.tamano,
    required this.imageRoute,
    required this.positionInitialX,
    required this.positionInitialY,
    required this.pixelsImage,
  }) : super(
          size: tamano,
        ) {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    await _loadAnimations().then((_) => {animation = _standingAnimation});
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: images.fromCache(imageRoute),
      srcSize: pixelsImage,
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

  @override
  void update(double dt) {
    // dt es el tiempo
    // que va haciendo

    position.x += 100 * dt;

    if (position.x > widthPhone) {
      position.x = positionInitialX;
    }

    CarBackGround colission = CarBackGround(
        images: images,
        positionInitialX: 0,
        positionInitialY: pixelsImage.y / 2);

    add(colission);
    super.update(dt);
  }
}
