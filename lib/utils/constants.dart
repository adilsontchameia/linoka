import 'package:flutter/material.dart';

abstract class AppConstants {
  static const backgroundContainerGridColor = Color.fromARGB(255, 22, 22, 22);
  static const backgroundContainerColor = Color.fromARGB(255, 22, 22, 22);
  //Audio Section Constants
  static const pause = 'Pause';
  static const score = 'Score';
  static const play = 'Play';
  static const backgroundSoundPath = 'fluffing_a_duck.mp3';
  static const snakeEatenSoundPath = 'torch_whoosh_panned.mp3';
  //Settings Sections Constants
  static const logImgPath = 'assets/logo.png';
  static const volumeSettings = 'Volume Settings';
  static const appInfo =
      'Linoka is a simple snake game made by Adilson Tchameia, the name of this app is originally derived from the Nguaguela / Ganguela language, which means SNAKE.\nNguaguela / Ganguela: Ethnic group that lives in the east and southeast of the Central Plateau of Angola - Cuando Cubango.';
  static const emailInfo = 'Email: adilsontchameia@gmail.com';
  static const socialInfo = 'Linkedin/Github: Adilson Tchameia';
  static const uiInfo = 'UI: Adilson Tchameia';
  static const audioInfo = 'Audio: Yago Tchameia';
  static const yearInfo = '@2023';
}
