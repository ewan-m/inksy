import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:inksy/styles/colours.dart';

class LetterDrawer extends CustomPainter {
  final List<Offset> points;
  final String currentLetter;
  final Map<String, List<Offset>> limits;

  LetterDrawer({
    this.points,
    this.limits,
    this.currentLetter,
  });

  @override
  bool shouldRepaint(LetterDrawer oldDelegate) {
    return oldDelegate.points != points;
  }

  void paint(Canvas canvas, Size size) {
    Paint letterPath = Paint()
      ..color = Colours.primary
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 15.0;

    Paint boundaryLine = Paint()
      ..color = Colours.lightGrey
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 2.5;

    if (limits != null) {
      limits.forEach((key, value) {
        if (value.isNotEmpty && value[0] != null && value[1] != null) {
          Offset bottomLeft = value[0];
          Offset topRight = value[1];
          canvas.drawLine(
            Offset(bottomLeft.dx, topRight.dy),
            Offset(topRight.dx, topRight.dy),
            boundaryLine,
          );
          canvas.drawLine(
            Offset(bottomLeft.dx, bottomLeft.dy),
            Offset(topRight.dx, bottomLeft.dy),
            boundaryLine,
          );
        }
      });
    }

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], letterPath);
      }
    }
  }
}
