import 'dart:math';

import 'package:colo_run/components/random_card/enemy.dart';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';

import '../../game.dart';
import '../cars/car_model.dart';

class Enemies extends Component with HasGameRef<ColoRunGame> {
  Images images;

  List<CarModel> enemies = [];
  final Timer timer = Timer(3, repeat: true);

  Enemies(this.images) {
    timer.onTick = randomEnemy;
  }

  @override
  void update(double dt) {
    timer.update(dt);
    super.update(dt);
  }

  @override
  void onMount() {
    if (enemies.isEmpty) {
      enemies = [
        CarModel(
            images: images,
            imageRoute: 'retro_r.png',
            pixelsImage: Vector2(167, 104),
            tamano: Vector2(75.0, 80),
            positionInitialX: -20,
            positionInitialY: gameRef.size.y / 2 + 100),
        CarModel(
            images: images,
            imageRoute: 'bombo_r.png',
            pixelsImage: Vector2(138, 92),
            tamano: Vector2(75.0, 80),
            positionInitialX: -20,
            positionInitialY: gameRef.size.y / 2)
      ];
    }

    timer.start();
    super.onMount();
  }

  randomEnemy() {
    final randomIndex = Random().nextInt(enemies.length);
    CarModel cardModel = enemies.elementAt(randomIndex);
    Car enemy = Car(
      imageRoute: '',
      images: cardModel.images,
      pixelsImage: cardModel.pixelsImage,
      positionInitialX: cardModel.positionInitialX,
      positionInitialY: cardModel.positionInitialY,
      tamano: cardModel.tamano,
    );

    enemy.anchor = Anchor.bottomRight;
    enemy.position =
        Vector2(cardModel.positionInitialX, cardModel.positionInitialY);
    enemy.size = cardModel.tamano;
    gameRef.add(enemy);
  }

  removeAllEnemies() {
    final enemies = gameRef.children.whereType<Car>();
    for (var enemy in enemies) {
      enemy.removeFromParent();
    }
  }
}
