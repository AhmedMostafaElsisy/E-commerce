import 'dart:math' as math;
import 'package:default_repo_app/Constants/app_constants.dart';
import 'package:flutter/material.dart';

class LoaderCanvas extends CustomPainter {
  double radius;
  LoaderCanvas({required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    Paint _arc = Paint()
      ..color = AppConstants.mainColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    Paint _arc2 = Paint()
      ..color = AppConstants.lightBlackGrayColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    Paint _circle = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.fill;

    Offset _center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(_center, size.width / 2, _circle);
    canvas.drawArc(
        Rect.fromCenter(
            center: _center,
            width: size.width * radius,
            height: size.height * radius),
        math.pi / 4,
        math.pi / 2,
        false,
        _arc);
    canvas.drawArc(
        Rect.fromCenter(
            center: _center,
            width: size.width * radius,
            height: size.height * radius),
        -math.pi / 4,
        -math.pi / 2,
        false,
        _arc2);
  }

  @override
  bool shouldRepaint(LoaderCanvas oldPaint) {
    return true;
  }
}
