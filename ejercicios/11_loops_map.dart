// imprimir todos los elementos de una map
void main() {
  var fruit = {1: 'Apple', 2: 'Banana', 3: 'Cherry', 4: 'Orange'};

  for (var key in fruit.keys) print(key);
  for (var value in fruit.values) print(value);

  for (var me in fruit.entries) {
    print("${me.key}: ${me.value}");
  }
}
