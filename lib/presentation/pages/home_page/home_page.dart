import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/presentation/snake_commands_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/logic/play_button_logic.dart';
import '../../../utils/logic/snake_direction_logic.dart';
import '../../../utils/snake_food_list.dart';
import '../widgets/app_info_alert.dart';
import '../widgets/blank_pixel.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/init_alert_dialog.dart';
import '../widgets/score_widget.dart';
import '../widgets/snake_pixel.dart';

class PlayGameScreen extends StatefulWidget {
  const PlayGameScreen({super.key});

  @override
  State<PlayGameScreen> createState() => _PlayGameScreenState();
}

class _PlayGameScreenState extends State<PlayGameScreen>
    with WidgetsBindingObserver {
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InitAlertDialog();
        },
      );
    });

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
      body: SafeArea(
        child: Column(
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
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    //No Grids
                    color: Colors.grey.shade900,
                    //With
                    //color: AppConstants.backgroundContainerColor,
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  //? Building Snake Box
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
                              constraints.biggest.aspectRatio * 2.8 / 2,
                        ),
                        itemBuilder: (context, index) {
                          if (gameProvider.snakePosition.contains(index)) {
                            return const SnakePixel();
                          } else if (gameProvider.foodPosition == index) {
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
            //? Menu Section
            Container(
              padding: const EdgeInsets.all(5.0),
              color: AppConstants.backgroundContainerColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AbsorbPointer(
                    absorbing: gameProvider.gamehasStarted ? true : false,
                    child: CustomElevatedButton(
                        gameProvider: gameProvider,
                        foregroundColor: Colors.white,
                        backgroundColor1: Colors.green,
                        buttonTitle: AppConstants.play,
                        onPressed: () {
                          playButtonLogic(context, gameProvider);
                        }),
                  ),
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
                  const ScoreWidget(),
                  AppInfoAlertDialog(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
