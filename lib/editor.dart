import 'package:flutter/material.dart';
import 'objects/line.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  @override
  Widget build(BuildContext context) {
    int currLineIndex = Line.currLineIndex;
    String string = 'line number: $currLineIndex\n';
    string += ('hi\nthere\nhow\nare\nyou?\n' * 100).trimRight();

    return GestureDetector(
      child: CustomPaint(painter: _EditorPainter(string)),
      onTapDown: (details) {
        setState(() {
          Line.setCurrLineIndex(details);
        });
      },
    );
  }
}

class _EditorPainter extends CustomPainter {
  _EditorPainter(this.string);

  final String string;

  @override
  void paint(Canvas canvas, Size size) {
    final lineStrings = string.split('\n');

    double offsetY = 0;
    int lineIndex = 0;

    for (String lineString in lineStrings) {
      final textPainter = TextPainter(
        text: TextSpan(text: lineString, style: const TextStyle(fontSize: 50)),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(canvas, Offset(0, offsetY));

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