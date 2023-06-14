// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../snake_commands_provider.dart';

// ignore: must_be_immutable
class AppInfoAlertDialog extends StatefulWidget {
  double? backgroundVolume;
  final AudioPlayer? backgroundSound;
  AppInfoAlertDialog({
    Key? key,
    this.backgroundVolume,
    this.backgroundSound,
  }) : super(key: key);
  @override
  State<AppInfoAlertDialog> createState() => _AppInfoAlertDialogState();
}

class _AppInfoAlertDialogState extends State<AppInfoAlertDialog> {
  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<SnakeCommandsProvider>();
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.info),
          color: Colors.white,
          onPressed: () {
            gameProvider.showInfoDialog(context);
          },
        )
      ],
    );
  }
}
