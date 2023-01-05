import 'dart:math';

import 'package:colo_run/components/cars/car.dart';
import 'package:colo_run/components/cars/car_model.dart';
import 'package:colo_run/game.dart';
import 'package:flame/components.dart';

// This class is responsible for spawning random enemies at certain
// interval of time depending upon players current score.
class CarManager extends Component with HasGameRef<ColoRunGame> {
  // A list to hold data for all the enemies.
  late final List<CarModel> _data = [
    CarModel(
        images: gameRef.images,
        imageRoute: 'bombo_r.png',
        pixelsImage: Vector2(138, 92),
        tamano: Vector2(75.0, 80),
        positionInitialX: -20,
        positionInitialY: gameRef.size.y / 2),
    CarModel(
      images: gameRef.images,
      imageRoute: 'retro_r.png',
      pixelsImage: Vector2(167, 104),
      tamano: Vector2(75.0, 80),
      positionInitialX: -20,
      positionInitialY: gameRef.size.y / 2 + 100,
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
