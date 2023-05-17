// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/snake_commands_provider.dart';
import '../utils/constants.dart';

// ignore: must_be_immutable
class AppInfoAlertDialog extends StatefulWidget {
  double backgroundVolume;
  final AudioPlayer backgroundSound;
  AppInfoAlertDialog({
    Key? key,
    required this.backgroundVolume,
    required this.backgroundSound,
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
            gameProvider.pauseGame();
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),
                            Slider(
                              value: widget.backgroundVolume,
                              min: 0,
                              max: 1,
                              divisions: 10,
                              onChanged: (newVolume) {
                                setState(() {
                                  widget.backgroundVolume = newVolume;
                                  widget.backgroundSound.setVolume(newVolume);
                                });
                              },
                              activeColor: Colors.green,
                            ),
                            const Divider(color: Colors.white),
                            const Text(AppConstants.appInfo,
                                textAlign: TextAlign.start),
                            const SizedBox(height: 2.0),
                            const Text(AppConstants.emailInfo),
                            const Text(AppConstants.socialInfo),
                            const Text(AppConstants.uiInfo),
                            const Text(AppConstants.audioInfo),
                            const Center(child: Text(AppConstants.yearInfo)),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        Column(
                          children: [
                            ElevatedButton(
                              style: TextButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                backgroundColor: Colors.black87,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                gameProvider.startGame(context);
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
          },
        )
      ],
    );
  }
}
