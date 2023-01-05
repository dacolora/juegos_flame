import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class WordObstacle extends PositionComponent {
  WordObstacle({required size, required position})
      : super(size: size, position: position) {
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
