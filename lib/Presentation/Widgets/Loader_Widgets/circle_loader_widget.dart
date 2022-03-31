import 'dart:math' as math;
import 'package:default_repo_app/Shapes/circle_loader_shape.dart';
import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = Tween(begin: 1.0, end: 1.2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, widget) {
          return Center(
            child: Transform.rotate(
              angle: _controller.status == AnimationStatus.forward
                  ? (math.pi * 2) * _controller.value
                  : -(math.pi * 2) * _controller.value,
              child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: CustomPaint(
                  painter: LoaderCanvas(radius: _animation.value),
                ),
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
