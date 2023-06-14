import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/utils/constants.dart';

import '../../snake_commands_provider.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<SnakeCommandsProvider>();
    return Column(
      children: [
        const Text(
          AppConstants.score,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18.0),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Text(
            gameProvider.currentScore.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20.0),
            key: ValueKey<int>(gameProvider.currentScore),
          ),
        ),
      ],
    );
  }
}
