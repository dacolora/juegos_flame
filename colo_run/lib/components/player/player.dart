import 'dart:math';

import 'package:colo_run/components/player/player_data.dart';
import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import '../../game.dart';
import 'package:flame/sprite.dart';
import '../first_enemy.dart/enemy.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../world/world_obstacle.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<ColoRunGame>, CollisionCallbacks {
  Images images;

  bool isCrash = false;
  Player(this.images)
      : super(
          size: Vector2.all(45.0),
        ) {
    add(RectangleHitbox());
  }
  late JoystickDirection direction;
  late JoystickDirection _collisionDirection;
  bool _hasCollided = false;
  final double _playerSpeed = 300.0;
  final double _animationSpeed = 0.15;
  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;

//Todos los componentes del motor Flame tienen algunas funciones básicas,
// como la carga y el renderizado dentro del bucle del juego al que están conectados. Por ahora, solo usarás
  @override
  Future<void> onLoad() async {
    await _loadAnimations().then((_) => {animation = _standingAnimation});
  }

  @override
  void onGameResize(Vector2 size) {
    x = size.x / 2; //24000
    y = size.y / 4; //24000
    //widthPhone = size.x;
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

    // position.clamp(
    //     Vector2.zero() + size / 2 - size / 20, gameRef.size - size / 2);
    // no se sale de la pantalla

    // gameRef.add(paticleComponent);
    movePlayer(gameRef.joystick.direction, dt);
  }

  void movePlayer(JoystickDirection joystickDirection, double dt) {
    switch (joystickDirection) {
      case JoystickDirection.up:
        if (canPlayerMoveUp()) {
          animation = _runUpAnimation;
          position.add(gameRef.joystick.delta * dt * 10);
        }
        break;
      case JoystickDirection.upLeft:
        if (canPlayerMoveLeft()) {
          animation = _runLeftAnimation;
          position.add(gameRef.joystick.delta * dt * 10);
        }
        break;
      case JoystickDirection.upRight:
        if (canPlayerMoveLeft()) {
          animation = _runRightAnimation;
          position.add(gameRef.joystick.delta * dt * 10);
        }
        break;
      case JoystickDirection.downRight:
        if (canPlayerMoveLeft()) {
          animation = _runRightAnimation;
          position.add(gameRef.joystick.delta * dt * 10);
        }
        break;
      case JoystickDirection.downLeft:
        if (canPlayerMoveLeft()) {
          animation = _runLeftAnimation;
          position.add(gameRef.joystick.delta * dt * 10);
        }
        break;
      case JoystickDirection.idle:
        animation = _standingAnimation;
        position.add(gameRef.joystick.delta * dt * 10);
        break;
      case JoystickDirection.right:
        if (canPlayerMoveRight()) {
          animation = _runRightAnimation;
          position.add(gameRef.joystick.delta * dt * 10);
        }
        break;
      case JoystickDirection.down:
        if (canPlayerMoveDown()) {
          animation = _runDownAnimation;
          position.add(gameRef.joystick.delta * dt * 10);
        }
        break;
      case JoystickDirection.left:
        if (canPlayerMoveLeft()) {
          animation = _runUpAnimation;
          position.add(gameRef.joystick.delta * dt * 10);
        }
        break;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    // if (other is WorldCollidable) {
    //   if (!_hasCollided) {
    //     _hasCollided = true;
    //     _collisionDirection = direction;
    //   }
    // }

    if (other is WordObstacle) {
      if (!_hasCollided) {
        _hasCollided = true;

        _collisionDirection = direction;
        direction = gameRef.joystick.direction;
        print('direction $direction');
        print('_collisionDirection $_collisionDirection');
      }
    }

    if ((other is FirstEnemy) && (!isCrash)) {
      crash();
    }
  }

  crash() {
    isCrash = true;
    gameRef.pauseEngine();
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    _hasCollided = false;
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
    if (_hasCollided && _collisionDirection == JoystickDirection.right) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveUp() {
    if (_hasCollided && _collisionDirection == JoystickDirection.up) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveDown() {
    if (_hasCollided && _collisionDirection == JoystickDirection.down) {
      return false;
    }
    return true;
  }
}
