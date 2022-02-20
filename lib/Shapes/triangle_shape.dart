import 'package:flutter/material.dart';

class TriangleCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 243, 33, 36)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width * 0.1250000, size.height * 0.1040000);
    path0.lineTo(size.width, size.height * 0.1040000);
    path0.lineTo(size.width, size.height * 0.9020000);
    path0.quadraticBezierTo(size.width * 0.3278125, size.height * 0.9065000,
        size.width * 0.1250000, size.height * 0.9080000);
    path0.quadraticBezierTo(size.width * 0.1868750, size.height * 0.7740000,
        size.width * 0.3125000, size.height * 0.5000000);
    path0.lineTo(size.width * 0.1250000, size.height * 0.1040000);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
