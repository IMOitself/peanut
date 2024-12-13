import 'package:flutter/material.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  int counter = 0;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CustomPaint(painter: _EditorTextPainter(counter)),
      onTap: () {
        setState(() {
          counter++;
        });
      },
    );
  }
}

List<Line> lines = [];

class Line {
  String? text;
  double? height;
  double? width;
}

class _EditorTextPainter extends CustomPainter {
  final int counter;

  _EditorTextPainter(this.counter);

  @override
  void paint(Canvas canvas, Size size) {
    String string = '$counter\n';
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
  bool shouldRepaint(_EditorTextPainter oldDelegate) {
    return oldDelegate.counter != counter;
  }
}
