import 'dart:ui';

import 'package:colo_run/components/first_enemy.dart/enemy.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'components/diamont/diamont_component.dart';
import 'components/espada/espada_component.dart';
import 'components/play_draggable/play_draggable.dart';
import 'components/player/player.dart';
import '../helpers/enums.dart';
import 'components/world/world.dart';
import 'components/world/world_obstacle.dart';
import 'components/world/world_collidable.dart';
import 'components/world/world_collidable.dart';
import 'package:hive/hive.dart';

import 'helpers/map_loader.dart';
import 'components/player/player_data.dart';

class ColoRunGame extends FlameGame with HasCollisionDetection, HasDraggables {
  late Player _player;
  late FirstEnemy enemy;
  late DraggableComponent draggMario;
  //final World _world = World();
  late PlayerData playerData;
  static const id = "RayWorld";
  static const imageAssets = ['player_spritesheet.png', 'bug.png', 'mario.png'];
  late TiledComponent homeMap;
  int countDiamantes = 0;
  @override
  Future<void> onLoad() async {
    await images.loadAll(imageAssets);
    // await add(_world);

    playerData = await _readPlayerData();
    //addWorldCollision();
    _player = Player(images);

    homeMap = await TiledComponent.load('poke.tmx', Vector2.all(32.0));
    add(homeMap);

    enemy = FirstEnemy(images, homeMap);
    draggMario = DraggableComponent(images, homeMap);
    //_player.position = _world.size / 2;

    _player.position.y = homeMap.size.y / 2 + homeMap.size.y / 3;
    _player.position.x = homeMap.size.x / 2;
    final obstacleGroup = homeMap.tileMap.getLayer<ObjectGroup>('Colision');

    for (final obj in obstacleGroup!.objects) {
      add(
        WordObstacle(
          position: Vector2(obj.x, obj.y),
          size: Vector2(obj.width, obj.height),
        ),
      );
    }
    addEspadas(homeMap, this);
    addDiamonts(homeMap, this, playerData);

    // camera.viewport = FixedResolutionViewport(// zoom
    //     Vector2(homeMap.size.x / 4, homeMap.size.y / 4));

    ///
    ///
    // centra al jugador en la mitad
    //_enemy.position = _world.size / 2;

    // esto genera que el jugador se quede estatico y sea el mapa el que se mueve
    // cuando llega al final del mapa, este es capas de ya mover el muneco y no mover el mapa
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, homeMap.size.x, homeMap.size.y));
  }

  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
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

  void startGamePlay() {
    add(_player);
    add(enemy);
    add(draggMario);
  }

  // void addWorldCollision() async =>
  //     // ignore: avoid_function_literals_in_foreach_calls
  //     (await MapLoader.readRayWorldCollisionMap()).forEach((rect) {
  //       add(WorldCollidable()
  //         ..position = Vector2(rect.left, rect.top)
  //         ..width = rect.width
  //         ..height = rect.height);
  //     });
}
