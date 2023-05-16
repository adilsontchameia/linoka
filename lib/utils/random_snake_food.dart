import 'dart:math';

import 'package:flutter/material.dart';

class RandomSnakeFoodProvider extends ChangeNotifier {
  int randomFood = 0;
  List<String> typeFood = [
    '🍇',
    '🍈',
    '🍉',
    '🍊',
    '🍌',
    '🍍',
    '🍑',
    '🍒',
    '🍓',
    '🥝',
    '🍅',
    '🍎',
    '🍏',
    '🍐',
    '🍑',
    '🍋',
    '🌾',
    '🍚',
    '🍘',
    '🍙',
    '🫘'
  ];

  void rondomizeFood() {
    randomFood = Random().nextInt(typeFood.length);
    notifyListeners();
  }
}
