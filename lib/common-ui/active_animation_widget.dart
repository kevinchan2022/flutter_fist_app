import 'package:flutter/material.dart';

class ActiveAnimationWidget extends StatefulWidget {
  const ActiveAnimationWidget({super.key, required this.builder});

  final WidgetBuilder builder;

  @override
  State<ActiveAnimationWidget> createState() => _NavigatorItemWidgetState();
}

class _NavigatorItemWidgetState extends State<ActiveAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    controller.forward();
    animation = Tween<double>(begin: 0.0, end: 1).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: widget.builder(context),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
