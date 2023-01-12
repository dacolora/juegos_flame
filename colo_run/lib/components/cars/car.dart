import 'package:colo_run/components/cars/backGroundColiision.dart';
import 'package:colo_run/components/cars/car_model.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game.dart';

class Car extends SpriteAnimationComponent with HasGameRef<ColoRunGame> {
  final CarModel carModel;

  late double widthPhone;
  late final SpriteAnimation _standingAnimation;
  final double _animationSpeed = 0.15;
  Car(
    this.carModel,
  ) : super(
          size: carModel.tamano,
        ) {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    await _loadAnimations().then((_) => {animation = _standingAnimation});
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: carModel.images.fromCache(carModel.imageRoute),
      srcSize: carModel.pixelsImage,
    );
    _standingAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
  }

  @override
  void onGameResize(Vector2 size) {
    x = carModel.positionInitialX; //24000
    y = carModel.positionInitialY; //24000
    widthPhone = size.x * 2;
    super.onGameResize(size);
  }

  @override
  void update(double dt) {
    // dt es el tiempo
    // que va haciendo
    carModel.isRightMoved ? position.x += 60 * dt : position.x -= 60 * dt;

    if (-200 > position.x || position.x > widthPhone) {
      removeFromParent();
    }

    CarBackGround colission = CarBackGround(
        images: carModel.images,
        positionInitialX: carModel.pixelsImage.x / 4,
        positionInitialY: carModel.pixelsImage.y - carModel.pixelsImage.y / 3,
        tamano: carModel.pixelsImage);

    add(colission);
    super.update(dt);
  }
}
