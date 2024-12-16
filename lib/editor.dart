import 'package:flutter/material.dart';

class Line {
  String? text;
  double? height;
  double? width;

  static List<Line> lines = [];
  static int currLineIndex = 0;

  static void updateLines(int i, String s, double? h, double? w) {
    Line line = Line()
      ..text = s
      ..height = h
      ..width = w;

    if (i >= lines.length) {
      lines.add(line);
    } else {
      lines[i] = line;
    }
  }

  static void setCurrLineIndex(TapDownDetails details) {
    Offset tapPosition = details.localPosition;
    double offsetTop = 0;
    double tapY = tapPosition.dy;

    for (Line line in lines) {
      double lineBottom = offsetTop + line.height!;
      if (tapY < lineBottom) {
        currLineIndex = lines.indexOf(line);
        break;
      }

      offsetTop += line.height!;
    }
  }
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
