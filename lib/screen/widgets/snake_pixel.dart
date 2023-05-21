import 'package:flutter/material.dart';

class SnakePixel extends StatelessWidget {
  const SnakePixel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 0.2,
              )
            ]),
      ),
    );
  }
}
