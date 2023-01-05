import 'dart:math';

import 'package:colo_run/components/cars/car.dart';
import 'package:colo_run/components/cars/car_model.dart';
import 'package:colo_run/game.dart';
import 'package:flame/components.dart';

class CarManager extends Component with HasGameRef<ColoRunGame> {
  late final List<CarModel> _data = [
    CarModel(
        images: gameRef.images,
        imageRoute: 'bombo_r.png',
        isRightMoved: true,
        pixelsImage: Vector2(138, 92),
        tamano: Vector2(138, 92),
        positionInitialX: -20,
        positionInitialY: gameRef.size.y / 2),
    CarModel(
      images: gameRef.images,
      imageRoute: 'retro_r.png',
      isRightMoved: true,
      pixelsImage: Vector2(167, 104),
      tamano: Vector2(167, 104),
      positionInitialX: -20,
      positionInitialY: gameRef.size.y / 2 + 100,
    ),
    CarModel(
      images: gameRef.images,
      imageRoute: '4x4_l.png',
      isRightMoved: false,
      pixelsImage: Vector2(91, 62),
      tamano: Vector2(91, 62),
      positionInitialX: gameRef.size.x + 100,
      positionInitialY: gameRef.size.y / 2 + 200,
    ),
    CarModel(
      images: gameRef.images,
      imageRoute: 'ambulancia_l.png',
      isRightMoved: false,
      pixelsImage: Vector2(94, 65),
      tamano: Vector2(94, 65),
      positionInitialX: gameRef.size.x + 100,
      positionInitialY: gameRef.size.y / 2 + 200,
    )
  ];

  // Random generator required for randomly selecting enemy type.
  final Random _random = Random();

  // Timer to decide when to spawn next enemy.
  final Timer _timer = Timer(1.5, repeat: true);

  CarManager() {
    _timer.onTick = spawnRandomEnemy;
  }

  // This method is responsible for spawning a random enemy.
  void spawnRandomEnemy() {
    /// Generate a random index within [_data] and get an [EnemyData].
    final randomIndex = _random.nextInt(_data.length);
    final carData = _data.elementAt(randomIndex);
    final enemy = Car(carData);

    enemy.position = Vector2(_data[randomIndex].positionInitialX - 80,
        _data[randomIndex].positionInitialY);
    enemy.size = _data[randomIndex].tamano;
    gameRef.add(enemy);
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  void removeAllEnemies() {
    final enemies = gameRef.children.whereType<Car>();
    for (var enemy in enemies) {
      enemy.removeFromParent();
    }
  }
}
