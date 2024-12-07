import 'package:flutter/material.dart';

class EditorTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final string = ('hi\nthere\nhow\nare\nyou?\n' * 100).trimRight();
    final strings = string.split('\n');

    double offsetY = 0;
    for (String string in strings){
      final textPainter = TextPainter(
        text: TextSpan(
          text: string,
          style: const TextStyle(fontSize: 50)),
        textDirection: TextDirection.ltr,
      )..layout();

    textPainter.paint(canvas, Offset(0, offsetY));

    offsetY += textPainter.height;
    if (offsetY > size.height) break;
    }
  }
  
  @override
  bool shouldRepaint(EditorTextPainter oldDelegate) => false;
}