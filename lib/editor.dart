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
    return GestureDetector(
      child: CustomPaint(painter: _EditorTextPainter()),
      onTapDown: (details) {
        setState(() {
          Line.setCurrLineIndex(details);
        });
      },
    );
  }
}

class _EditorTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    int currLineIndex = Line.currLineIndex;
    String string = 'line number: $currLineIndex\n';
    string += ('hi\nthere\nhow\nare\nyou?\n' * 100).trimRight();

    final strings = string.split('\n');

    double offsetY = 0;
    int lineIndex = 0;

    for (String string in strings) {
      final textPainter = TextPainter(
        text: TextSpan(text: string, style: const TextStyle(fontSize: 50)),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(canvas, Offset(0, offsetY));

      offsetY += textPainter.height;
      if (offsetY > size.height) break;

      Line.updateLines(
          lineIndex, string, textPainter.height, textPainter.width);
      lineIndex++;
    }
  }

  @override
  bool shouldRepaint(_EditorTextPainter oldDelegate) => true;
}
