void main() {
  double first, second;

  String cercano(
      {required double primerValor,
      required double segundoValor,
      required double Comparar}) {
    late String text;
    first = (primerValor - Comparar).abs();
    second = (segundoValor - Comparar).abs();

    if (first > second) {
      text =
          'El valor $Comparar es mas cercano a $segundoValor que a $primerValor';
    } else if (first < second) {
      text =
          'El valor $Comparar es mas cercano a $primerValor que a $segundoValor';
    } else if (first == second) {
      text =
          'El valor $Comparar essta a la misma distancia que $primerValor y $segundoValor';
    }
    return text;
  }

  print(cercano(primerValor: 1000, segundoValor: 2000, Comparar: 100));
  print(cercano(primerValor: 10, segundoValor: 90, Comparar: 77));
  print(cercano(primerValor: 0, segundoValor: 100, Comparar: 50));
}
