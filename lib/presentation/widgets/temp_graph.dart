import 'package:bloc_demo/modesl/weather_model.dart';
import 'package:flutter/material.dart';

class TempGraphPainter extends CustomPainter {
  final List<ForecastDay> forecast;
  final double maxTemp;
  final double minTemp;

  TempGraphPainter(this.forecast, this.maxTemp, this.minTemp);

  @override
  void paint(Canvas canvas, Size size) {
    final paintMax = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final paintMin = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final pointPaintMax = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final pointPaintMin = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final pathMax = Path();
    final pathMin = Path();

    // Padding control
    double topPadding = 10;
    double bottomPadding = 50;
    double chartHeight = size.height - topPadding - bottomPadding;
    double gapX = size.width / (forecast.length - 1);

    List<Offset> maxPoints = [];
    List<Offset> minPoints = [];

    for (int i = 0; i < forecast.length; i++) {
      double x = i * gapX;

      double yMax =
          topPadding +
          (maxTemp - forecast[i].maxTempC) / (maxTemp - minTemp) * chartHeight;

      double yMin =
          topPadding +
          (maxTemp - forecast[i].minTempC) / (maxTemp - minTemp) * chartHeight;

      maxPoints.add(Offset(x, yMax));
      minPoints.add(Offset(x, yMin));
    }

    _createSmoothPath(pathMax, maxPoints);
    _createSmoothPath(pathMin, minPoints);

    // Draw the lines
    canvas.drawPath(pathMax, paintMax);
    canvas.drawPath(pathMin, paintMin);

    final textStyleMax = const TextStyle(
      color: Colors.red,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );

    final textStyleMin = const TextStyle(
      color: Colors.blue,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );

    // Draw points + temp labels
    for (int i = 0; i < maxPoints.length; i++) {
      final maxP = maxPoints[i];
      final minP = minPoints[i];

      canvas.drawCircle(maxP, 4, pointPaintMax);
      _drawText(
        canvas,
        '${forecast[i].maxTempC.toInt()}°',
        maxP.dx,
        maxP.dy - 14,
        textStyleMax,
      );

      canvas.drawCircle(minP, 4, pointPaintMin);
      _drawText(
        canvas,
        '${forecast[i].minTempC.toInt()}°',
        minP.dx,
        minP.dy + 14,
        textStyleMin,
      );
    }
  }

  void _createSmoothPath(Path path, List<Offset> points) {
    if (points.isEmpty) return;

    path.moveTo(points.first.dx, points.first.dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final midX = (p0.dx + p1.dx) / 2;
      final midY = (p0.dy + p1.dy) / 2;
      path.quadraticBezierTo(p0.dx, p0.dy, midX, midY);
    }

    path.lineTo(points.last.dx, points.last.dy);
  }

  void _drawText(
    Canvas canvas,
    String text,
    double x,
    double y,
    TextStyle style,
  ) {
    final textSpan = TextSpan(text: text, style: style);
    final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
