import 'package:flame/components.dart' hide Timer;
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'dart:async';
import 'package:hive/hive.dart';
import 'components/cars/car.dart';
import 'components/cars/car_manager.dart';
import 'components/cars/car_model.dart';
import 'components/player/player.dart';
import 'components/player/player_data.dart';
import 'components/world/world_obstacle.dart';

class ColoRunGame extends FlameGame with HasCollisionDetection, HasDraggables {
  late Player _player;
  late Car car1, car2;
  late PlayerData playerData;
  late JoystickComponent joystick;
  late TiledComponent homeMap;
  late CarManager _carManager;

  @override
  static const id = "ColoRun";
  static const imageAssets = [
    'player_spritesheet.png',
    '4x4_l.png',
    'ambulancia_l.png',
    'camioneta_l.png',
    'chiquito_gray_r.png',
    'chiquito_rojo_r.png',
    'deportivo_l.png',
    'escarabajo_r.png',
    'gray_car_r.png',
    'negro_l.png',
    'policia_r.png',
    'rojo_l.png',
    'renault_r.png',
    'rojo_r.png',
    'taxi_r.png',
    'van_l.png',
    'retro_r.png',
    'green.png',
    'parallax/plx-1.png',
    'bombo_r.png',
    'parallax/plx-2.png',
    'parallax/plx-3.png',
    'parallax/plx-4.png',
    'parallax/plx-5.png',
    'parallax/plx-6.png',
  ];
  @override
  Future<void> onLoad() async {
    await images.loadAll(imageAssets);
    _player = Player(images);
    _carManager = CarManager();

    car1 = Car(CarModel(
      images: images,
      imageRoute: 'retro_r.png',
      pixelsImage: Vector2(167, 104),
      tamano: Vector2(75.0, 80),
      positionInitialX: -20,
      positionInitialY: size.y / 2 + 100,
    ));

    car2 = Car(CarModel(
        images: images,
        imageRoute: 'bombo_r.png',
        pixelsImage: Vector2(138, 92),
        tamano: Vector2(75.0, 80),
        positionInitialX: -20,
        positionInitialY: size.y / 2));

    ;
    playerData = await _readPlayerData();
    homeMap = await TiledComponent.load('map.tmx', Vector2.all(32.0));
    add(homeMap);

    final obstacleGroup = homeMap.tileMap.getLayer<ObjectGroup>('Colision');

    for (final obj in obstacleGroup!.objects) {
      add(
        WordObstacle(
          position: Vector2(obj.x, obj.y),
          size: Vector2(obj.width, obj.height),
        ),
      );
    }

    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, homeMap.size.x, homeMap.size.y));

    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
        knob: CircleComponent(radius: 25, paint: knobPaint),
        background: CircleComponent(radius: 50, paint: backgroundPaint),
        //margin: const EdgeInsets.only(left: 280, bottom: 40),
        position: Vector2(size.x - 50, size.y - 50));

    add(joystick);
  }

  void startGamePlay() {
    add(_player);
    // add(car2);
    // add(car1);
    add(_carManager);

    Timer.periodic(Duration(seconds: 10), (timer) {});

    // add(draggMario);
  }

  void _disconnectActors() {
    _carManager.removeAllEnemies();
    _carManager.removeAllEnemies();
  }

  // This method reset the whole game world to initial state.
  void reset() {
    // First disconnect all actions from game world.
    _disconnectActors();

    // Reset player data to inital values.
    playerData.currentScore = 0;
    playerData.lives = 5;
  }

  Future<PlayerData> _readPlayerData() async {
    final playerDataBox =
        await Hive.openBox<PlayerData>('ColoRunGame.PlayerDataBox');
    final playerData = playerDataBox.get('ColoRunGame.PlayerData');

    // If data is null, this is probably a fresh launch of the game.
    if (playerData == null) {
      // In such cases store default values in hive.
      await playerDataBox.put('ColoRunGame.PlayerData', PlayerData());
    }

    // Now it is safe to return the stored value.
    return playerDataBox.get('ColoRunGame.PlayerData')!;
  }
}
