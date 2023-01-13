void main() {
  find_par(int n) {
    if (n % 2 == 0) {
      print('el numero $n es par');
    } else {
      print('el numero $n NO es par');
    }
  }

  //Returns the remainder of the Euclidean division. The Euclidean division of two integers a and b yields two integers q and r such that a == b * q + r and 0 <= r < b.abs().

//The Euclidean division is only defined for integers, but can be easily extended to work with doubles. In that case, q is still an integer, but r may have a non-integer value that still satisfies 0 <= r < |b|.

  find_par(5);
  find_par(10);
  find_par(96);

  generar_pares() {
    List pares = [];
    int count = 0;
    int num = 0;
  }
}
