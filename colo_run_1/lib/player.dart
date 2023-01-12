import 'package:colo_run/components/cars/backGroundColiision.dart';
import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../../game.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameRef<ColoRunGame> {
  Images images;

  bool isCrash = false;
  late JoystickDirection direction;
  late JoystickDirection _collisionDirection;
  bool _hasCollided = false;

  final double _animationSpeed = 0.15;
  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
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
    y = size.y - size.y / 30; //24000
    super.onGameResize(size);
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: images.fromCache('player_spritesheet.png'),
      srcSize: Vector2(29.0, 32.0),
    );

    _runDownAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);

    _runLeftAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);

    _runUpAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);

    _runRightAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

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
    direction = gameRef.joystick.direction;

    position.clamp(
        Vector2.zero() + size / 2 - size / 20, gameRef.size - size / 2);
    //print(size / 2 - size / 20); [17.1,17.1]
    // print(gameRef.size - size / 2);
    // no se sale de la pantalla

    // gameRef.add(paticleComponent);
    movePlayer(gameRef.joystick.direction, dt);
  }

  crash() {
    isCrash = true;
    gameRef.pauseEngine();
  }

  void movePlayer(JoystickDirection joystickDirection, double dt) {
    switch (joystickDirection) {
      case JoystickDirection.up:
        if (canPlayerMoveUp()) {
          animation = _runUpAnimation;
          position.add(gameRef.joystick.delta * dt * 5);
        }
        break;
      case JoystickDirection.upLeft:
        if (canPlayerMoveLeft()) {
          animation = _runLeftAnimation;
          position.add(gameRef.joystick.delta * dt * 5);
        }
        break;
      case JoystickDirection.upRight:
        if (canPlayerMoveRight()) {
          animation = _runRightAnimation;
          position.add(gameRef.joystick.delta * dt * 5);
        }
        break;
      case JoystickDirection.downRight:
        if (canPlayerMoveRight()) {
          animation = _runRightAnimation;
          position.add(gameRef.joystick.delta * dt * 5);
        }
        break;
      case JoystickDirection.downLeft:
        if (canPlayerMoveLeft()) {
          animation = _runLeftAnimation;
          position.add(gameRef.joystick.delta * dt * 5);
        }
        break;
      case JoystickDirection.idle:
        animation = _standingAnimation;
        position.add(gameRef.joystick.delta * dt * 5);
        break;
      case JoystickDirection.right:
        if (canPlayerMoveRight()) {
          animation = _runRightAnimation;
          position.add(gameRef.joystick.delta * dt * 5);
        }
        break;
      case JoystickDirection.down:
        if (canPlayerMoveDown()) {
          animation = _runDownAnimation;
          position.add(gameRef.joystick.delta * dt * 5);
        }
        break;
      case JoystickDirection.left:
        if (canPlayerMoveLeft()) {
          animation = _runUpAnimation;
          position.add(gameRef.joystick.delta * dt * 5);
        }
        break;
    }
  }

  bool canPlayerMoveLeft() {
    if (_hasCollided &&
        (_collisionDirection == JoystickDirection.left ||
            _collisionDirection == JoystickDirection.upLeft ||
            _collisionDirection == JoystickDirection.downLeft)) {
      _hasCollided = false;
      return false;
    }
    return true;
  }

  bool canPlayerMoveRight() {
    if (_hasCollided &&
        (_collisionDirection == JoystickDirection.right ||
            _collisionDirection == JoystickDirection.upRight ||
            _collisionDirection == JoystickDirection.downRight)) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveUp() {
    if (_hasCollided &&
        (_collisionDirection == JoystickDirection.up ||
            _collisionDirection == JoystickDirection.upLeft ||
            _collisionDirection == JoystickDirection.upRight)) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveDown() {
    if (_hasCollided &&
        (_collisionDirection == JoystickDirection.down ||
            _collisionDirection == JoystickDirection.downLeft ||
            _collisionDirection == JoystickDirection.downRight)) {
      return false;
    }
    return true;
  }
}
