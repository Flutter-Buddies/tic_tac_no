import 'package:flutter/material.dart';

class CrossPainter extends CustomPainter {
  CrossPainter({this.drawingColor});
  final Color drawingColor;
  @override
  void paint(Canvas canvas, Size size) {
    // paint is the brush
    var paint = Paint()
      ..color = drawingColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.25 * size.width;

    // path is the drawing
    var path = Path()
      ..lineTo(size.width, size.height)
      ..moveTo(0, size.height)
      ..lineTo(size.width, 0);

    // Todo: get shadow working
    canvas.drawShadow(path, Colors.black, 5.0, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  String toString() => 'cross';
}

class TrianglePainter extends CustomPainter {
  TrianglePainter({this.drawingColor});
  final Color drawingColor;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = drawingColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.25 * size.width;

    var path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  String toString() => 'triangle';
}

class CirclePainter extends CustomPainter {
  CirclePainter({this.drawingColor});
  final Color drawingColor;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = drawingColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.25 * size.width;

    var path1 = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: 0.5 * size.width));

    canvas.drawPath(path1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  String toString() => 'circle';
}

class SquirclePainter extends CustomPainter {
  SquirclePainter({this.drawingColor});
  final Color drawingColor;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = drawingColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.25 * size.width;

    var path1 = Path()
      ..addRRect(
        RRect.fromLTRBR(
          0,
          0,
          size.width,
          size.height,
          Radius.circular(0.35 * size.width),
        ),
      );
    canvas.drawPath(path1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  String toString() => 'squircle';
}
