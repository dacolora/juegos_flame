void main() {
  List<int> lista = [1, 2, 3, 4, 5];

  late List<int> lista_cuadrada = [];
  for (var i in lista) {
    print(i * i);
    lista_cuadrada.add(i * i);
  }

  print(lista_cuadrada);
}
