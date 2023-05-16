import 'package:flutter/material.dart';

import '../providers/snake_commands_provider.dart';

void playButtonLogic(BuildContext context, SnakeCommandsProvider gameProvider) {
  if (gameProvider.gamehasStarted == false) {
    gameProvider.startGame(context);
  }
  if (gameProvider.gamehasPaused == true) {
    gameProvider.gamehasStarted = false;
    gameProvider.startGame(context);
  }
}
