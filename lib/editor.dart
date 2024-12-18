import 'package:flutter/material.dart';
import 'objects/line.dart';

String string = '';

class Editor extends StatefulWidget {
  Editor(String s, {super.key}){
    string = s;
  }

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CustomPaint(painter: _EditorPainter()),
      onTapDown: (details) {
        setState(() {
          Line.setCurrLineIndex(details);
        });
      },
    );
  }
}

class _EditorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lineStrings = string.split('\n');

    double offsetY = 0;
    int lineIndex = 0;

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

      // DEBUG
      int currentLine = Line.currLineIndex;
      int linesSize = Line.lines.length;
      TextPainter(
        text: TextSpan(text: '$currentLine\n$linesSize', style: const TextStyle(fontSize: 20)),
        textDirection: TextDirection.ltr,
      )..layout()..paint(canvas, Offset(size.width - 50, size.height / 2));

      offsetY += textPainter.height;
      if (offsetY > size.height) break;

      Line.updateLines(
          lineIndex, lineString, textPainter.width, textPainter.height);
      lineIndex++;
    }
  }

  @override
  bool shouldRepaint(_EditorPainter oldDelegate) => true;
}