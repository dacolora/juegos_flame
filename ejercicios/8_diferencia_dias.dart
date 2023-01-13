// Ejercicio 8: Calcular la Diferencia en Días de Dos Fechas Dadas
void main() {
  DateTime day;
  DateTime day2;
  Duration diference;
  day = DateTime.utc(2023, 1, 20);
  day2 = DateTime.now();

  diference = day.difference(day2);

  print(diference.inDays);

  final berlinWallFell = DateTime(1989, DateTime.november, 9);
  final today = DateTime.now();
  final difference = berlinWallFell.difference(today);
  print(difference.inDays);
  print(difference.inDays / 365);
}
