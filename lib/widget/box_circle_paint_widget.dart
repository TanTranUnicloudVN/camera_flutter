import 'package:flutter/material.dart';

class BoxCirclePaint extends CustomPainter {
  final double x;
  final double y;
  final double radius;
  final Color color;

  /// Paint circle

  BoxCirclePaint({
    required this.x,
    required this.y,
    required this.radius,
    this.color = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(x, y),
        radius,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill
          ..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(covariant BoxCirclePaint oldDelegate) =>
      x != oldDelegate.x || y != oldDelegate.y;
}
