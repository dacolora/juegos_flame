import 'package:colo_run/components/world/world_collidable.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../../colo_run_game.dart';

class EspadasComponent extends SpriteComponent with HasGameRef<ColoRunGame> {
  EspadasComponent() : super() {
    debugMode = true;
    // Devuelve si este [componente] está en modo de depuración o no.
    //Cuando se agrega un hijo al [Componente], obtiene el mismo [debugMode] que tiene su padre cuando está preparado.
    //Devuelve false de forma predeterminada. Anularlo o establecerlo en true para
    // usar el modo de depuración. Puede usar este valor para habilitar comportamientos de depuración para su juego y muchos componentes mostrarán información adicional en la pantalla cuando se active el modo de depuración.
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
  }
}

// void addEspadas(TiledComponent homeMap, ColoRunGame game) async {
//   final diamentGroup = homeMap.tileMap.getLayer<ObjectGroup>('Espadas');

//   for (var diam in diamentGroup!.objects) {
//     print('id ${diam.id} class ${diam.class_}');

//     print('entra');
//     game.add(EspadasComponent()
//       ..position = Vector2(diam.x, diam.y)
//       ..sprite = await game.loadSprite('diamante.png')
//       ..size = Vector2(diam.width, diam.height)
//       ..debugMode = true);
//   }

void addEspadas(TiledComponent homeMap, ColoRunGame game) async {
  final diamentGroup = homeMap.tileMap.getLayer<ObjectGroup>('Espadas');
  for (var diam in diamentGroup!.objects) {
    // print('id ${diam.id} class ${diam.class_}');
    switch (diam.class_) {
      case 'espada':
        game.add(EspadasComponent()
          ..position = Vector2(diam.x, diam.y)
          ..sprite = await game.loadSprite('espada.png')
          //..size = Vector2(diam.width, diam.height)
          ..width = diam.width
          ..height = diam.height
          ..debugMode = true);
        break;
    }
  }
}
