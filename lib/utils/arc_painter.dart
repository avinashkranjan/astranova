import 'dart:math';

import 'package:flutter/material.dart';

class ArcPainter extends CustomPainter {
  final List<String> planets;
  final int selectedIndex;
  final Animation<double> animation;

  ArcPainter({
    required this.planets,
    required this.selectedIndex,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.black, Colors.blueAccent, Colors.black],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final center = Offset(size.width / 2, size.height * 1.5);
    final radiusX = size.width / 2;
    final radiusY = size.height / 1.5;

    canvas.drawArc(
      Rect.fromCenter(center: center, width: radiusX * 3, height: radiusY * 3),
      pi,
      pi,
      false,
      paint,
    );

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    const angle = pi;
    final offset = Offset(
      center.dx + radiusX * cos(angle) - 20,
      center.dy + radiusY * sin(angle) - 20,
    );

    textPainter.text = TextSpan(
      text: planets[selectedIndex],
      style: const TextStyle(
        fontSize: 20,
        color: Colors.yellow,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);

    final iconOffset = Offset(
      center.dx + radiusX * cos(angle) - 40,
      center.dy + radiusY * sin(angle) - 60,
    );
    final iconPainter = Paint()..color = Colors.yellow;
    canvas.drawCircle(iconOffset, 10, iconPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
