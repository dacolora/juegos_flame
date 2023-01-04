import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

import '../../game.dart';
import '../player/player.dart';

class Car extends SpriteAnimationGroupComponent
    with HasGameRef<ColoRunGame>, CollisionCallbacks {
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
  bool isHit = false;
  Timer hitTimer = Timer(1);
  @override
  // void onMount() {
  //   hitTimer.onTick = () {
  //     current = EnemyStates.run;
  //     isHit = false;
  //   };
  //   current = EnemyStates.run;

  //   add(RectangleHitbox());
  //   super.onMount();
  // }

  @override
  void update(double dt) {
    x -= 200 * dt;

    if (x <= 0) {
      //  gameRef.gameProvider.currentScore += 1;
      removeFromParent();
    }

    position.x += 100 * dt;

    if (position.x > widthPhone) {
      position.x = positionInitialX;
    }

    hitTimer.update(dt);
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player && !isHit) {
      // current = EnemyStates.attack;
      // isHit = true;
      // hitTimer.start();
    }
    super.onCollision(intersectionPoints, other);
  }
}
