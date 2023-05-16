import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../screen/widgets/dialog_box.dart';
import '../utils/constants.dart';
import '../utils/game_command_enums.dart';
import '../utils/snake_food_list.dart';

class SnakeCommandsProvider extends ChangeNotifier {
  //RandomFood Provider
  int randomFood = 0;

  void rondomizeFood() {
    randomFood = Random().nextInt(typeFood.length);
    notifyListeners();
  }
  //Final Params for random food provider

  //PlaySound Provider
  AudioPlayer backgroundSound = AudioPlayer();
  AudioPlayer eatingSound = AudioPlayer();
  double backgroundVolume = 0.020;
  bool isPlayingSound = false;

  void playBackgroundSound() async {
    isPlayingSound = true;
    backgroundSound.play(AssetSource(AppConstants.backgroundSoundPath));
    backgroundSound.onPlayerComplete.listen((event) {
      backgroundSound.play(AssetSource(AppConstants.backgroundSoundPath));
    });
    backgroundSound.setVolume(backgroundVolume);
    notifyListeners();
  }

  void playEatingSound() async {
    eatingSound.play(AssetSource(AppConstants.snakeEatenSoundPath));
    eatingSound.setVolume(0.3);
    notifyListeners();
  }

  //Pausar o som
  void stopBackgroundSound() async {
    isPlayingSound = false;
    backgroundSound.stop();
    notifyListeners();
  }

  //Resume
  void resumeBackgroundSound() async {
    backgroundSound.resume();
    notifyListeners();
  }

  //Resume
  void pauseBackgroundSound() async {
    isPlayingSound = false;
    backgroundSound.pause();
    notifyListeners();
  }
  //Final Play Sound Provider

  //CurrentScore
  int currentScore = 0;
  //Game Started
  bool gamehasStarted = false;
  bool gamehasPaused = false;
  //Grid Dimensions
  int rowSize = 15;
  int totalNumberSquares = 315;
  //Snake Position
  List<int> snakePosition = [
    0,
  ];
  //SnakeDirection is Initialy To The Right
  var currentDirection = SnakeDirection.RIGHT;
  //Food Position
  int foodPosition = 55;
  //GameTimer
  Timer? gameTimer;
  Duration snakeSpeed = const Duration(milliseconds: 200);

  //Moving the snake
  void moveSnake() {
    switch (currentDirection) {
      case SnakeDirection.RIGHT:
        {
          //If Snake is at right wall, need to re-adjust
          //% => Module => The Remain
          if (snakePosition.last % rowSize == 14) {
            //gameOver();
            snakePosition.add(snakePosition.last + 1 - rowSize);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
        }
        break;
      case SnakeDirection.LEFT:
        {
          //If Snake is at right wall, need to re-adjust
          //% => Module => The Remain
          if (snakePosition.last % rowSize == 0) {
            //gameOver();
            snakePosition.add(snakePosition.last - 1 + rowSize);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
        }
        break;
      case SnakeDirection.UP:
        {
          //If Snake is at right wall, need to re-adjust
          //% => Module => The Remain
          if (snakePosition.last < rowSize) {
            snakePosition
                .add(snakePosition.last - rowSize + totalNumberSquares);
          } else {
            snakePosition.add(snakePosition.last - rowSize);
          }
        }
        break;
      case SnakeDirection.DOWN:
        {
          //If Snake is at right wall, need to re-adjust
          //% => Module => The Remain
          if (snakePosition.last + rowSize > totalNumberSquares) {
            snakePosition
                .add(snakePosition.last + rowSize - totalNumberSquares);
          } else {
            snakePosition.add(snakePosition.last + rowSize);
          }
        }
        break;
      default:
        notifyListeners();
    }
    //Snake is eating the food
    if (snakePosition.last == foodPosition) {
      eatingFood();
    } else {
      //Remove The Tail
      snakePosition.removeAt(0);
    }
  }

  //GameActions Provider
  void startGame(BuildContext context) {
    gamehasStarted = true;
    gameTimer = Timer.periodic(snakeSpeed, (timer) {
      moveSnake();

      //Check If Game Over is Over
      if (gameOver()) {
        gameTimer!.cancel();
        //Display a message to the user
        openDialogBox(context, currentScore);
        newGame();
      }
    });
    notifyListeners();
  }

  void newGame() {
    snakePosition = [
      0,
    ];
    foodPosition = 55;
    currentDirection = SnakeDirection.RIGHT;
    gamehasStarted = false;
    currentScore = 0;
    notifyListeners();
  }

  void pauseGame() {
    gameTimer!.cancel();
    notifyListeners();
  }

  void eatingFood() {
    //Increasing the Score when eating
    currentScore++;
    //Play a Sound When Eating
    playEatingSound();
    //Randomize Food
    rondomizeFood();
    //Making Sure The Food Is Not Where The Snake Is
    while (snakePosition.contains(foodPosition)) {
      foodPosition = Random().nextInt(totalNumberSquares);
    }
    notifyListeners();
  }

  bool gameOver() {
    //Game is over when the snake runs into itself
    //This occurs when there is a duplicate position in the snakePosition list
    //This list is the body of the snake (no head)
    List<int> bodySnake = snakePosition.sublist(0, snakePosition.length - 1);
    if (bodySnake.contains(snakePosition.last)) {
      return true;
    }
    notifyListeners();
    return false;
  }
}
