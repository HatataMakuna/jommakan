import 'dart:math';

class NameRandom {
  final foodAdjectives = [
    'Nasi',
    'Nasi Lemak',
    'Spicy Chicken',
    'Chicken Rice',
    'Mee Sedap',
    'Spicy Noodle',
    'Orang Juice',
    'Apple Juice',
    'Coffee',
    'Nasi Goreng',
    'Nase Kampong',
    'Mee Soup',
    'Break',
    'Burger',
    'Cole',
    'Persi',
    'Sprite',
    'Milo',
    'Nescafe',
    'Spicy Chicken',
  ];

  

  String getFoodName() {
    String adjective = foodAdjectives[getNum(0, foodAdjectives.length - 1)];
    

    return '$adjective';
  }

  int getNum(int min, int max) {
    int res = min + Random().nextInt(max + 1 - min);
    return res;
  }
}
