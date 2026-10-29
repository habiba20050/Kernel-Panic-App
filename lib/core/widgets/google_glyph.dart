import 'dart:math' as math;

import 'package:flutter/material.dart';

/// The Google "G", painted so the app does not have to ship a bitmap for it.
///
/// Pass [color] to paint the single-colour mark used by the design, or leave it
/// null for the four-colour brand mark.
class GoogleGlyph extends StatelessWidget {
  const GoogleGlyph({super.key, this.size = 18, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _GoogleGlyphPainter(color),
    );
  }
}

class _GoogleGlyphPainter extends CustomPainter {
  const _GoogleGlyphPainter(this.mono);

  final Color? mono;

  static const Color _red = Color(0xFFEA4335);
  static const Color _yellow = Color(0xFFFBBC05);
  static const Color _green = Color(0xFF34A853);
  static const Color _blue = Color(0xFF4285F4);

  static double _rad(double degrees) => degrees * math.pi / 180;

  @override
  void paint(Canvas canvas, Size size) {
    final double side = size.shortestSide;
    final Offset centre = Offset(side / 2, side / 2);
    final double stroke = side * 0.22;
    final double radius = side / 2 - stroke / 2;
    final Rect ring = Rect.fromCircle(center: centre, radius: radius);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;

    final Color red = mono ?? _red;
    final Color yellow = mono ?? _yellow;
    final Color green = mono ?? _green;
    final Color blue = mono ?? _blue;

    // Angles are measured clockwise from the positive x-axis (east).
    // A small wedge at the upper right stays unpainted: that is the opening
    // that makes the ring read as a "G".
    canvas.drawArc(ring, _rad(216), _rad(104), false, paint..color = red);
    canvas.drawArc(ring, _rad(140), _rad(76), false, paint..color = yellow);
    canvas.drawArc(ring, _rad(54), _rad(86), false, paint..color = green);
    canvas.drawArc(ring, _rad(344), _rad(70), false, paint..color = blue);

    // Horizontal arm of the G.
    final Paint arm = Paint()..color = blue;
    canvas.drawRect(
      Rect.fromLTWH(
        centre.dx,
        centre.dy - stroke / 2,
        side / 2 - stroke * 0.1,
        stroke,
      ),
      arm,
    );
  }

  @override
  bool shouldRepaint(_GoogleGlyphPainter oldDelegate) =>
      oldDelegate.mono != mono;
}
