//Ejercicio 3, invertir cadena de caracteres

void main() {
  String invertirCadena(String palabra) {
    late List<String> list = [];
    late String newWord;

    for (var i = palabra.length - 1; i >= 0; i--) {
      list.add(palabra[i]);
      newWord = list.join();
    }
    return newWord;
  }

  print(invertirCadena('validar esto'));
}
