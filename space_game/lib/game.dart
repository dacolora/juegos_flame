import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

class SpaceGame extends FlameGame {
  late TiledComponent map;

  @override
  Future<void>? onLoad() async {
    map = await TiledComponent.load('map.tmx', Vector2.all(32));
    add(map);
    return super.onLoad();
  }
}
