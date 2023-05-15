import 'package:flutter/material.dart';
import 'package:snake_game/utils/blank_pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Grid Dimensions
  int rowSize = 10;
  int totalNumberSquares = 100;
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
            child: GridView.builder(
              itemCount: totalNumberSquares,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rowSize,
              ),
              itemBuilder: (context, index) {
                return const BlankPixel();
              },
            ),
          ),
          //Play Button
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
