import 'package:flutter/material.dart';
import 'objects/line.dart';

String text = '';

class Editor extends StatefulWidget {
  Editor(String s, {super.key}) {
    text = s;
  }

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: Line.setCurrLineIndex,
        child: CustomPaint(painter: _EditorPainter()),
      );
}

class _EditorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double offsetY = 0;
    int lineIndex = 0;
    final lineStrings = text.split('\n');

    for (String lineString in lineStrings) {
      final textPainter = TextPainter(
        text: TextSpan(text: lineString, style: const TextStyle(fontSize: 30)),
        textDirection: TextDirection.ltr,
      )..layout();

      // HIGHLIGHT
      if (Line.currLineIndex == lineIndex) {
        canvas.drawRect(
          Rect.fromLTWH(0, offsetY, size.width, textPainter.height),
          Paint()..color = Colors.red,
        );
      }

      // TEXT
      textPainter.paint(canvas, Offset(0, offsetY));

      debug(canvas, size);

      offsetY += textPainter.height;
      if (offsetY > size.height) break;

      Line.updateLines(
          lineIndex, lineString, textPainter.width, textPainter.height);
      lineIndex++;
    }
  }

  @override
  bool shouldRepaint(_EditorPainter oldDelegate) => true;

  void debug(Canvas canvas, Size size) {
    TextPainter(
      text: TextSpan(
          text: '${Line.currLineIndex}\n${Line.lines.length}',
          style: const TextStyle(fontSize: 20)),
      textDirection: TextDirection.ltr,
    )
      ..layout()
      ..paint(canvas, Offset(size.width - 50, size.height / 2));
  }
}
