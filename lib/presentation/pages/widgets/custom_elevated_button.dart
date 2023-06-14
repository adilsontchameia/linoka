import 'package:flutter/material.dart';

import '../../snake_commands_provider.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.gameProvider,
    required this.foregroundColor,
    required this.backgroundColor1,
    this.backgroundColor2,
    required this.buttonTitle,
    required this.onPressed,
  });

  final SnakeCommandsProvider gameProvider;
  final Color foregroundColor;
  final Color backgroundColor1;
  final Color? backgroundColor2;
  final String buttonTitle;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        foregroundColor: foregroundColor,
        backgroundColor: !gameProvider.gamehasStarted
            ? backgroundColor1
            : backgroundColor2, // foreground
      ),
      onPressed: onPressed,
      child: Text(
        buttonTitle,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
      ),
    );
  }
}
