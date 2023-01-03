import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart' hide Draggable;

import '../../colo_run_game.dart';

class DraggableComponent extends SpriteComponent with Draggable {
  Vector2? dragDeltaPosition;
  Images images;
  bool isCrash = false;
  final TiledComponent<FlameGame> world;
  DraggableComponent(this.images, this.world)
      : super(
          size: Vector2.all(50.0),
        ) {
    add(RectangleHitbox());
  }

  @override
  void onGameResize(Vector2 size) {
    x = world.size.x / 2; //24000
    y = world.size.y / 2; //24000
    super.onGameResize(size);
  }

  @override
  Future<void> onLoad() async {
    // sprite = Sprite(
    //   images.fromCache('mario.png'),
    // );
    sprite = Sprite(
      images.fromCache('mario.png'),
    );
    size = Vector2(81, 200);
    position = size / 2;
  }

  @override
  void update(double dt) {
    super.update(dt);
    debugColor =
        isDragged && parent is ColoRunGame ? Colors.greenAccent : Colors.purple;
  }

  @override
  bool onDragStart(DragStartInfo info) {
    dragDeltaPosition = info.eventPosition.game - position;
    return false;
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    if (parent is! ColoRunGame) {
      return true;
    }
    final dragDeltaPosition = this.dragDeltaPosition;
    if (dragDeltaPosition == null) {
      return false;
    }
    position.setFrom(info.eventPosition.game - dragDeltaPosition);
    return false;
  }

  @override
  bool onDragCancel() {
    dragDeltaPosition = null;
    return false;
  }

  @override
  bool onDragEnd(DragEndInfo info) {
    dragDeltaPosition = null;
    return false;
  }
}
