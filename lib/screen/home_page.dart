import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/screen/widgets/blank_pixel.dart';
import 'package:snake_game/screen/widgets/food_pixel.dart';
import 'package:snake_game/screen/widgets/snake_pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// ignore: constant_identifier_names
enum SnakeDirection { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  //CurrentScore
  int currentScore = 0;
  //Grid Dimensions
  int rowSize = 10;
  int totalNumberSquares = 100;
  //Snake Position
  List<int> snakePosition = [
    0,
    1,
    2,
  ];
  //SnakeDirection is Initialy To The Right
  var currentDirection = SnakeDirection.RIGHT;
  //Food Position
  int foodPosition = 55;
  //Start Game Method
  void startGame() {
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        //Moving the Snake
        moveSnake();

        //Check If Game Over is Over
        if (gameOver()) {
          timer.cancel();
          //Display a message to the user
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('GameOver'),
                content: Text('Your Score Is: $currentScore'),
              );
            },
          );
        }
      });
    });
  }

  //Moving the snake
  void moveSnake() {
    switch (currentDirection) {
      case SnakeDirection.RIGHT:
        {
          //If Snake is at right wall, need to re-adjust
          //% => Module => The Remain
          if (snakePosition.last % rowSize == 9) {
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
    }
    //Snake is eating the food
    if (snakePosition.last == foodPosition) {
      eatingFood();
    } else {
      //Remove The Tail
      snakePosition.removeAt(0);
    }
  }

  //Eating the food
  void eatingFood() {
    //Increasing the Score when eating
    currentScore++;
    //Making Sure The Food Is Not Where The Snake Is
    while (snakePosition.contains(foodPosition)) {
      foodPosition = Random().nextInt(totalNumberSquares);
    }
  }

  //GameOver
  bool gameOver() {
    //Game is over when the snake runs into itself
    //This occurs when there is a duplicate position in the snakePosition list

    //This list is the body of the snake (no head)
    List<int> bodySnake = snakePosition.sublist(0, snakePosition.length - 1);
    if (bodySnake.contains(snakePosition.last)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //High Scores
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //User Current Score
                const Text('Current Score'),
                Text(currentScore.toString()),
                //High Score, Top5, Top10
                //const Text('currentDirection.toString()'),
              ],
            ),
          ),
          //GameGrid
          Expanded(
            flex: 4,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                //If Delta Y is Positive
                //If Going Up, Can't Go Down
                if (details.delta.dy > 0 &&
                    currentDirection != SnakeDirection.UP) {
                  //Moving Down
                  currentDirection = SnakeDirection.DOWN;
                } else if (details.delta.dy < 0 &&
                    currentDirection != SnakeDirection.DOWN) {
                  //Moving Up
                  currentDirection = SnakeDirection.UP;
                }
              },
              onHorizontalDragUpdate: (details) {
                //If Delta Y is Positive
                if (details.delta.dx > 0 &&
                    currentDirection != SnakeDirection.LEFT) {
                  //Moving Right
                  currentDirection = SnakeDirection.RIGHT;
                } else if (details.delta.dx < 0 &&
                    currentDirection != SnakeDirection.RIGHT) {
                  //Moving Left
                  currentDirection = SnakeDirection.LEFT;
                }
              },
              child: GridView.builder(
                itemCount: totalNumberSquares,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowSize,
                ),
                itemBuilder: (context, index) {
                  if (snakePosition.contains(index)) {
                    return const SnakePixel();
                  } else if (foodPosition == index) {
                    return const FoodPixel();
                  } else {
                    return const BlankPixel();
                  }
                },
              ),
            ),
          ),
          //Play Button
          Expanded(
            flex: 1,
            child: SizedBox(
              child: Center(
                child: MaterialButton(
                  color: Colors.pink,
                  onPressed: startGame,
                  child: const Text('Play'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
