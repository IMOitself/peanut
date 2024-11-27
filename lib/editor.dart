import 'package:flutter/material.dart';

class EditorTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const string = 'hi:D!';

    final textPainter = TextPainter(
      text: const TextSpan(
        text: string,
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, const Offset(0, 0));
  }

  @override
  bool shouldRepaint(EditorTextPainter oldDelegate) => false;
}