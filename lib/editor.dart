import 'package:flutter/material.dart';

List<Line> lines = [];
int currLineNumber = 0;

class Line {
  String? text;
  double? height;
  double? width;
}

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
          updateCurrLineNumber(details.localPosition);
        });
      },
    );
  }

  void updateCurrLineNumber(Offset position) {
    double offsetTop = 0;
    double tapY = position.dy;

    for (Line line in lines) {
      double lineBottom = offsetTop + line.height!;
      if (tapY < lineBottom) {
        currLineNumber = lines.indexOf(line);
        break;
      }

      offsetTop += line.height!;
    }
  }
}

class _EditorTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    String string = 'line number: $currLineNumber\n';
    string += ('hi\nthere\nhow\nare\nyou?\n' * 100).trimRight();

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
  bool shouldRepaint(_EditorTextPainter oldDelegate) => true;
}
