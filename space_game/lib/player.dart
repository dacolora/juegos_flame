import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../../game.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameRef<SpaceGame> {
  Images images;

  final double _animationSpeed = 0.15;

  late final SpriteAnimation _standingAnimation;

  Player(this.images)
      : super(
          size: Vector2.all(38.0),
        ) {
    add(RectangleHitbox());
  }

//Todos los componentes del motor Flame tienen algunas funciones básicas,
// como la carga y el renderizado dentro del bucle del juego al que están conectados. Por ahora, solo usarás
  @override
  Future<void> onLoad() async {
    await _loadAnimations().then((_) => {animation = _standingAnimation});
  }

  @override
  void onGameResize(Vector2 size) {
    x = size.x / 2; //24000
    y = size.y - size.y / 2; //24000
    super.onGameResize(size);
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: images.fromCache('player_spritesheet.png'),
      srcSize: Vector2(29.0, 32.0),
    );

    _standingAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
  }

  @override
  void update(double dt) {
    // update es una función exclusiva de los componentes Flame.
    // Se llamará cada vez que se deba renderizar un fotograma, y Flame se
    //asegurará de que todos los componentes de su juego se actualicen al mismo tiempo.
    //El delta representa cuánto tiempo ha pasado desde el último ciclo de actualización y se puede usar para mover al jugador de manera predecible.
    super.update(dt);

    position.clamp(
        Vector2.zero() + size / 2 - size / 20, gameRef.size - size / 2);
    //print(size / 2 - size / 20); [17.1,17.1]
    // print(gameRef.size - size / 2);
    // no se sale de la pantalla

    // gameRef.add(paticleComponent);
  }
}
