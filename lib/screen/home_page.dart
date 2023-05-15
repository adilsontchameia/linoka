import 'dart:async';

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
        moveSnake();
      });
    });
  }

  void moveSnake() {
    switch (currentDirection) {
      case SnakeDirection.RIGHT:
        {
          //Add a New head
          snakePosition.add(snakePosition.last + 1);
          //Remove The Tail
          snakePosition.removeAt(0);
        }
        break;
      case SnakeDirection.LEFT:
        {
          //Add a New head
          snakePosition.add(snakePosition.last - 1);
          //Remove The Tail
          snakePosition.removeAt(0);
        }
        break;
      case SnakeDirection.UP:
        {
          //Add a New head
          snakePosition.add(snakePosition.last - rowSize);
          //Remove The Tail
          snakePosition.removeAt(0);
        }
        break;
      case SnakeDirection.DOWN:
        {
          //Add a New head
          snakePosition.add(snakePosition.last + rowSize);
          //Remove The Tail
          snakePosition.removeAt(0);
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //High Scores
          Expanded(
            child: Container(),
          ),
          //GameGrid
          Expanded(
            flex: 3,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                //If Delta Y is Positive
                //If Going Up, Can't Go Down
                if (details.delta.dy > 0 &&
                    currentDirection != SnakeDirection.UP) {
                  //Moving Down
                  currentDirection = SnakeDirection.DOWN;
                  print('DOWN');
                } else if (details.delta.dy < 0 &&
                    currentDirection != SnakeDirection.DOWN) {
                  //Moving Up
                  currentDirection = SnakeDirection.UP;
                  print('UP');
                }
              },
              onHorizontalDragUpdate: (details) {
                //If Delta Y is Positive
                if (details.delta.dx > 0 &&
                    currentDirection != SnakeDirection.LEFT) {
                  //Moving Right
                  currentDirection = SnakeDirection.RIGHT;
                  print('RIGHT');
                } else if (details.delta.dx < 0 &&
                    currentDirection != SnakeDirection.RIGHT) {
                  //Moving Left
                  currentDirection = SnakeDirection.LEFT;
                  print('DOWN');
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
