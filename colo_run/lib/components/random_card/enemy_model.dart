import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class CarModel {
  final Images images;
  final String imageRoute;
  final Vector2 tamano;
  final double positionInitialX;
  final double positionInitialY;
  final Vector2 pixelsImage;

  CarModel({
    required this.images,
    required this.tamano,
    required this.imageRoute,
    required this.positionInitialX,
    required this.positionInitialY,
    required this.pixelsImage,
  });
}
