import 'package:flutter/material.dart';
import 'dart:math' as math;

class SnakePixel extends StatefulWidget {
  const SnakePixel({super.key});

  @override
  SnakePixelState createState() => SnakePixelState();
}

class SnakePixelState extends State<SnakePixel>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
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
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _controller!.value * 2.0 * math.pi,
          child: child,
        );
      },
    );
  }
}
