import 'package:flutter/material.dart';

class DecorativeCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5000000, size.height * 0.004201681);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.004201681);
    path_0.cubicTo(
        size.width * 0.7737815,
        size.height * 0.004201681,
        size.width * 0.9957983,
        size.height * 0.2262185,
        size.width * 0.9957983,
        size.height * 0.5000000);
    path_0.lineTo(size.width * 0.9957983, size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.9957983,
        size.height * 0.7737815,
        size.width * 0.7737815,
        size.height * 0.9957983,
        size.width * 0.5000000,
        size.height * 0.9957983);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.9957983);
    path_0.cubicTo(
        size.width * 0.2262185,
        size.height * 0.9957983,
        size.width * 0.004201681,
        size.height * 0.7737815,
        size.width * 0.004201681,
        size.height * 0.5000000);
    path_0.lineTo(size.width * 0.004201681, size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.004201681,
        size.height * 0.2262185,
        size.width * 0.2262185,
        size.height * 0.004201681,
        size.width * 0.5000000,
        size.height * 0.004201681);
    path_0.close();

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint0Stroke.color = const Color(0xffe4f353).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color =
        const Color.fromRGBO(255, 255, 255, .75).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
