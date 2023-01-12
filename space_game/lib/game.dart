import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:space_game/player.dart';

import 'package:flame/extensions.dart';

class SpaceGame extends FlameGame {
  late TiledComponent map;
  late Player _player;

  static const imageAssets = [
    'player_spritesheet.png',
  ];

  @override
  Future<void>? onLoad() async {
    await images.loadAll(imageAssets);
    map = await TiledComponent.load('map.tmx', Vector2.all(32));
    add(map);
    _player = Player(images);
    add(_player);

    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, map.size.x, map.size.y));
    return super.onLoad();
  }
}
