import 'package:flutter/material.dart';

class BoxRectPaint extends CustomPainter {
  final double top;
  final double left;
  final double width;
  final double height;
  final Color color;

  /// Paint rectangle that your face need to move into

  BoxRectPaint({
    required this.top,
    required this.left,
    required this.width,
    required this.height,
    this.color = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromLTWH(left, top, width, height),
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(covariant BoxRectPaint oldDelegate) =>
      top != oldDelegate.top ||
      left != oldDelegate.left ||
      width != oldDelegate.width ||
      height != oldDelegate.height;
}
