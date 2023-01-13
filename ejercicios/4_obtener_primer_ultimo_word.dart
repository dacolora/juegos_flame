// Ejercicio 4. obtener el primer y ultimo caracter de una palabra

void main() {
  String obtenerCaracteres(String palabra) {
    return 'primera letra ${palabra[0]}, ultima letra ${palabra[palabra.length - 1]} ';
  }

  print(obtenerCaracteres('validar esto'));
}
