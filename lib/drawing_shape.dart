import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawingShape extends CustomPainter {
  List<Offset> points;

  DrawingShape({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.bevel
      ..isAntiAlias = true
      ..strokeWidth = 25.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingShape oldDelegate) {
    return true;
  }
}
