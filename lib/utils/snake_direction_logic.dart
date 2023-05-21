import 'package:flutter/material.dart';

import '../providers/snake_commands_provider.dart';

void swipeLeftAndRight(
    DragUpdateDetails details, SnakeCommandsProvider gameProvider) {
  if (details.delta.dx > 0 &&
      gameProvider.currentDirection != SnakeDirection.left) {
    //Moving Right
    gameProvider.currentDirection = SnakeDirection.right;
  } else if (details.delta.dx < 0 &&
      gameProvider.currentDirection != SnakeDirection.right) {
    //Moving Left
    gameProvider.currentDirection = SnakeDirection.left;
  }
}

void swipeDownAndUp(
    DragUpdateDetails details, SnakeCommandsProvider gameProvider) {
  if (details.delta.dy > 0 &&
      gameProvider.currentDirection != SnakeDirection.up) {
    //Moving Down
    gameProvider.currentDirection = SnakeDirection.down;
  } else if (details.delta.dy < 0 &&
      gameProvider.currentDirection != SnakeDirection.down) {
    //Moving Up
    gameProvider.currentDirection = SnakeDirection.up;
  }
}
