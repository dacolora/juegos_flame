// Ejercicio 2. Valor del area de un circulo apartir de su radio ,
// valor del volumen de una esfera mediante su radio
import 'dart:math';

void main() {
  double area(double radio) {
    return pi * radio * radio;
  }

  double areaPow(double radio) {
    return pi * pow(radio, 2);
  }

  double areasimple(double radio) {
    return 3.1416 * pow(radio, 2);
  }

  double volEsfera(double radio) {
    return 4 / 3 * pi * pow(radio, 3);
  }

  print('El area del circulo es ${areasimple(5)}');
  print('El area del circulo es ${area(5)}');
  print('El area del circulo es ${areaPow(5)}');
  print('El volumen de la esfera es ${volEsfera(5)}');
}
