import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/providers/snake_commands_provider.dart';
import 'package:snake_game/screen/widgets/app_info_alert.dart';
import 'package:snake_game/screen/widgets/blank_pixel.dart';
import 'package:snake_game/screen/widgets/custom_elevated_button.dart';
import 'package:snake_game/screen/widgets/score_widget.dart';
import 'package:snake_game/screen/widgets/snake_pixel.dart';
import '../utils/constants.dart';
import '../utils/snake_direction_logic.dart';
import '../utils/snake_food_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  SnakeCommandsProvider snakeProvider = SnakeCommandsProvider();

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    snakeProvider.stopBackgroundSound();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    snakeProvider.playBackgroundSound();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //Resuming from the settings
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      snakeProvider.pauseBackgroundSound();
    }
    if (state == AppLifecycleState.resumed) {
      snakeProvider.playBackgroundSound();
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<SnakeCommandsProvider>();
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                //If Delta Y is Positive
                swipeDownAndUp(details, gameProvider);
              },
              onHorizontalDragUpdate: (details) {
                //If Delta Y is Positive
                swipeLeftAndRight(details, gameProvider);
              },
              child: Container(
                color: AppConstants.backgroundContainerGridColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.5),
                  child: LayoutBuilder(
                    builder: (context, constraints) => GridView.builder(
                      itemCount: gameProvider.totalNumberSquares,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gameProvider.rowSize,
                        childAspectRatio:
                            constraints.biggest.aspectRatio * 3 / 2,
                      ),
                      itemBuilder: (context, index) {
                        if (gameProvider.snakePosition.contains(index)) {
                          return const SnakePixel();
                        } else if (gameProvider.foodPosition == index) {
                          //return const FoodPixel();
                          return Text(
                            typeFood[gameProvider.randomFood],
                            style: const TextStyle(fontSize: 18.0),
                          );
                        } else {
                          return const BlankPixel();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5.0),
            color: AppConstants.backgroundContainerColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevatedButton(
                    gameProvider: gameProvider,
                    foregroundColor: Colors.white,
                    backgroundColor1: Colors.green,
                    buttonTitle: AppConstants.play,
                    onPressed: () {
                      playButtonLogic(gameProvider);
                    }),
                const SizedBox(width: 5.0),
                AbsorbPointer(
                  absorbing: !gameProvider.gamehasStarted ? true : false,
                  child: CustomElevatedButton(
                      gameProvider: gameProvider,
                      foregroundColor: Colors.white,
                      backgroundColor1: Colors.grey,
                      backgroundColor2: Colors.amber,
                      buttonTitle: AppConstants.pause,
                      onPressed: () {
                        gameProvider.pauseGame();
                        gameProvider.gamehasPaused = true;
                      }),
                ),
                ScoreWidget(gameProvider: gameProvider),
                AppInfoAlertDialog(
                    backgroundSound: gameProvider.backgroundSound,
                    backgroundVolume: gameProvider.backgroundVolume),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void playButtonLogic(SnakeCommandsProvider gameProvider) {
    if (gameProvider.gamehasStarted == false) {
      gameProvider.startGame(context);
    }
    if (gameProvider.gamehasPaused == true) {
      gameProvider.gamehasStarted = false;
      gameProvider.startGame(context);
    }
  }
}
