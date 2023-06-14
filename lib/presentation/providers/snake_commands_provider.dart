import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/presentation/pages/widgets/game_over_dialog.dart';

import '../../utils/constants.dart';
import '../../utils/snake_food_list.dart';

enum SnakeDirection { up, down, left, right }

class SnakeCommandsProvider extends ChangeNotifier {
  //RandomFood Provider
  int randomFood = 0;
  void rondomizeFood() {
    randomFood = Random().nextInt(typeFood.length);
    notifyListeners();
  }

  List<int> scoreSpeed = [30, 40, 50, 60, 70, 80, 90, 100];
  //PlaySound Provider
  AudioPlayer backgroundSound = AudioPlayer();
  AudioPlayer eatingSound = AudioPlayer();
  double backgroundVolume = 0.050;
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

  void playEatingSound() {
    eatingSound.play(AssetSource(AppConstants.snakeEatenSoundPath));
    eatingSound.setVolume(backgroundVolume);
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
  var currentDirection = SnakeDirection.right;
  //Food Position
  int foodPosition = 55;
  //GameTimer
  Timer? gameTimer;
  Duration snakeSpeed = const Duration(milliseconds: 200);

  //Moving the snake
  void moveSnake() {
    switch (currentDirection) {
      case SnakeDirection.right:
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
      case SnakeDirection.left:
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
      case SnakeDirection.up:
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
      case SnakeDirection.down:
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
    playBackgroundSound();
    foodPosition = 55;
    currentDirection = SnakeDirection.right;
    gamehasStarted = false;
    currentScore = 0;
    notifyListeners();
  }

  void showInfoDialog(BuildContext context) async {
    if (gamehasStarted) {
      gameTimer!.cancel();
    } else {
      debugPrint('Game Not Started');
    }

    showDialog(
      context: context,
      builder: (context) {
        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Image.asset(AppConstants.logImgPath),
              content: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppConstants.volumeSettings,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    Slider(
                      value: backgroundVolume,
                      min: 0,
                      max: 1,
                      divisions: 10,
                      onChanged: (newVolume) {
                        setState(() {
                          backgroundVolume = newVolume;
                          backgroundSound.setVolume(newVolume);
                        });
                      },
                      activeColor: Colors.green,
                    ),
                    const Divider(color: Colors.black),
                    const Text(
                      AppConstants.appInfo,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 2.0),
                    const Text(AppConstants.emailInfo,
                        style: TextStyle(color: Colors.black)),
                    const Text(AppConstants.socialInfo,
                        style: TextStyle(color: Colors.black)),
                    const Text(AppConstants.uiInfo,
                        style: TextStyle(color: Colors.black)),
                    const Text(AppConstants.audioInfo,
                        style: TextStyle(color: Colors.black)),
                    const Center(
                        child: Text(AppConstants.yearInfo,
                            style: TextStyle(color: Colors.black))),
                  ],
                ),
              ),
              actions: <Widget>[
                Column(
                  children: [
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        backgroundColor: Colors.black87,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        resumeGame();
                      },
                      child: const Text('Exit',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const Text('version 1.0',
                        style: TextStyle(color: Colors.black))
                  ],
                ),
              ],
            );
          }),
        );
      },
    );
    notifyListeners();
  }

  void pauseGame() {
    gameTimer!.cancel();
    gamehasStarted = false;
    notifyListeners();
  }

  void resumeGame() {
    gameTimer!.isActive;
    notifyListeners();
  }

  void increaseSpeed() {
    gamehasStarted = true;
    gameTimer = Timer.periodic(snakeSpeed, (timer) {
      moveSnake();
    });
    notifyListeners();
  }

  void eatingFood() {
    //Increasing the Score when eating
    currentScore++;

    //Increasing speed
    if (currentScore >= 30 && currentScore <= 100) {
      if (scoreSpeed.contains(currentScore)) {
        increaseSpeed();
      }
    }

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
    pauseGame();
    notifyListeners();
    return false;
  }
}
