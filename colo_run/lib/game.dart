import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'components/player/player.dart';
import 'components/player/player_data.dart';
import 'helpers/enums.dart';

class ColoRunGame extends FlameGame with HasCollisionDetection, HasDraggables {
  late Player _player;
  late PlayerData playerData;
  late JoystickComponent joystick;
  @override
  static const id = "ColoRun";
  static const imageAssets = [
    'player_spritesheet.png',
    'parallax/plx-1.png',
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
    playerData = await _readPlayerData();
    // aca se carga la imagen en cache y se peude compartir en toda parte

    final parallaxBackGround = await loadParallaxComponent([
      // la primera q se ponga es la de mas al fondo
      ParallaxImageData("parallax/plx-1.png"),
      ParallaxImageData("parallax/plx-2.png"),
      ParallaxImageData("parallax/plx-3.png"),
    ],
        baseVelocity: Vector2(0, 50),
        // velocidad del fondo
        // eje x y eje y, se mueve horizontal
        repeat: ImageRepeat.repeatY,
        // estar repitiendo el fondo
        velocityMultiplierDelta: Vector2(0, 1.4));

    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, size.x, size.y));

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
    // add(enemy);
    // add(draggMario);
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

  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }

  // @override
  // void onTap() {
  //   //player.jump();
  // }
}