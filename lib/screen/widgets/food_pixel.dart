import 'package:flutter/material.dart';

class FoodBlinkingWidget extends StatefulWidget {
  const FoodBlinkingWidget({super.key, required this.typeFood});
  final String typeFood;
  @override
  FoodBlinkingWidgetState createState() => FoodBlinkingWidgetState();
}

class FoodBlinkingWidgetState extends State<FoodBlinkingWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController!.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController!,
      child: const Text(
        ' widget.typeFood',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
