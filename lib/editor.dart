import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  const Editor({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: EditorTextPainter(),
    );
  }
}
List<Line> lines = [];

class EditorTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final string = ('hi\nthere\nhow\nare\nyou?\n' * 100).trimRight();
    final strings = string.split('\n');

    double offsetY = 0;
    for (String string in strings) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: string,
          style: const TextStyle(fontSize: 50)),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(canvas, Offset(0, offsetY));

    offsetY += textPainter.height;
    if (offsetY > size.height) break;

    lines.add(Line()
      ..text = string
      ..height = textPainter.height
      ..width = textPainter.width);
    }
  }

  @override
  bool shouldRepaint(EditorTextPainter oldDelegate) => false;
}

class Line {
  String? text;
  double? height;
  double? width;
}