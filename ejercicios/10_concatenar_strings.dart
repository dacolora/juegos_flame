// emular el funcionamiento del producto de cadena
void main() {
  String producto_cadena({required String cadena, required int repeticion}) {
    late String resultado = '';

    int i = 0;

    while (i < repeticion) {
      i++;
      resultado += cadena;
    }
    return resultado;
  }

  print('hola' * 3);
  print(producto_cadena(cadena: 'hola', repeticion: 3));
}

//The for and while statement are used to create loops. The break and continue statments are used to alter the loop execution.
// Loops are used to execute statements multiple times or to traverse containers.