import 'package:flutter/material.dart';

Future<dynamic> openDialogBox(BuildContext context, int currentScore) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Center(child: Text('You Loose')),
        content: Text(
          'Score: ${currentScore.toString()}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
      );
    },
  );
}
