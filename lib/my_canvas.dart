import 'package:flutter/material.dart';

class MyCanvas extends StatelessWidget {
  final double height;
  final double width;
  final List<Offset>? offset;
  final Offset scenePoint;

  const MyCanvas({
    Key? key,
    required this.height,
    required this.width,
    required this.offset,
    required this.scenePoint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final canvasSize = Size(width, height);

    return ClipRect(
      child: CustomPaint(
        isComplex: true,
        size: canvasSize,
        // * DRAWING PAINTER
        painter: DrawingPainter(offset, scenePoint),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  DrawingPainter(
    this.offsets,
      this.scenePoint
  );

  final List<Offset>? offsets;
  final Offset scenePoint;

  @override
  final painter = Paint()
    ..strokeWidth = 5
    ..color = Colors.indigoAccent
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final off = offsets;
    if (off == null) {
      return;
    }
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), painter);
    for (int i = 0; i < off.length - 1; i++) {
      if (off[i] != null && off[i + 1] != null) {
        canvas.drawLine(off[i], off[i + 1], painter);
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}
