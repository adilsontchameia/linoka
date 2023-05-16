// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

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
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.info),
          color: Colors.white,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return AlertDialog(
                      backgroundColor: Colors.grey,
                      title: Image.asset(AppConstants.logImgPath),
                      content: Column(
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
                          const Text(AppConstants.appInfo),
                          const Text(AppConstants.emailInfo),
                          const Text(AppConstants.socialInfo),
                          const Text(AppConstants.uiInfo),
                          const Text(AppConstants.audioInfo),
                          const Center(child: Text(AppConstants.yearInfo)),
                        ],
                      ),
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
