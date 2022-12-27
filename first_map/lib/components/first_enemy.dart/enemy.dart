import '../world.dart';
import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_tiled/flame_tiled.dart';

class FirstEnemy extends SpriteAnimationComponent with CollisionCallbacks {
  Images images;
  late double widthPhone;
  late final SpriteAnimation _standingAnimation;
  final TiledComponent<FlameGame> world;
  final double _animationSpeed = 0.15;
  FirstEnemy(this.images, this.world)
      : super(
          size: Vector2.all(50.0),
        ) {
    add(RectangleHitbox());
  }
  @override
  @override
  Future<void> onLoad() async {
    await _loadAnimations().then((_) => {animation = _standingAnimation});
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: images.fromCache('bug.png'),
      srcSize: Vector2(582, 482),
    );

    _standingAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
  }

  // Future<void> onLoad() async {
  //   animation = SpriteAnimation.fromFrameData(
  //       images.fromCache('bug.png'),
  //       SpriteAnimationData.sequenced(
  //           amount: 2,
  //           stepTime: 0.15,
  //           amountPerRow: 2,
  //           textureSize: Vector2(582, 482)));

  //   add(SpriteAnimationComponent(animation: animation));
  // }

// esto se remplaza por el super
  // @override
  // void onMount() {
  //   size *= 0.6;
  //   add(CircleHitbox());
  //   super.onMount();
  // }

  @override
  void onGameResize(Vector2 size) {
    print('enemy ${world.size.x}');
    print('enemy y${world.size.y}');
    x = world.size.x / 2; //24000
    y = world.size.y / 2; //24000
    widthPhone = size.x;
    super.onGameResize(size);
  }

  @override
  void update(double dt) {
    // dt es el tiempo
    // que va haciendo
    Vector2 sizePhone;

    // position.x -= 300 * dt;

    // if (position.x < 0) {
    //   position.x = widthPhone;
    // }
    super.update(dt);
  }
}
