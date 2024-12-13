import 'package:flutter/material.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _EditorTextPainter());
  }
}

List<Line> lines = [];

class Line {
  String? text;
  double? height;
  double? width;
}

class _EditorTextPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final string = ('hi\nthere\nhow\nare\nyou?\n' * 100).trimRight();
    final strings = string.split('\n');

    double offsetY = 0;
    for (String string in strings) {
      final textPainter = TextPainter(
        text: TextSpan(text: string, style: const TextStyle(fontSize: 50)),
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
  bool shouldRepaint(_EditorTextPainter oldDelegate) => false;
}
