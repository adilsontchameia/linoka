import 'package:flutter/material.dart';

import '../providers/snake_commands_provider.dart';
import 'game_command_enums.dart';

void swipeLeftAndRight(
    DragUpdateDetails details, SnakeCommandsProvider gameProvider) {
  if (details.delta.dx > 0 &&
      gameProvider.currentDirection != SnakeDirection.LEFT) {
    //Moving Right
    gameProvider.currentDirection = SnakeDirection.RIGHT;
  } else if (details.delta.dx < 0 &&
      gameProvider.currentDirection != SnakeDirection.RIGHT) {
    //Moving Left
    gameProvider.currentDirection = SnakeDirection.LEFT;
  }
}

void swipeDownAndUp(
    DragUpdateDetails details, SnakeCommandsProvider gameProvider) {
  if (details.delta.dy > 0 &&
      gameProvider.currentDirection != SnakeDirection.UP) {
    //Moving Down
    gameProvider.currentDirection = SnakeDirection.DOWN;
  } else if (details.delta.dy < 0 &&
      gameProvider.currentDirection != SnakeDirection.DOWN) {
    //Moving Up
    gameProvider.currentDirection = SnakeDirection.UP;
  }
}
