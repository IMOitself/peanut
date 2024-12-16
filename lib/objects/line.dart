import 'package:flutter/material.dart';

class Line {
  String? text;
  double? width;
  double? height;

  static List<Line> lines = [];
  static int currLineIndex = 0;

  static void updateLines(int i, String s, double? w, double? h) {
    Line line = Line()
      ..text = s
      ..width = w
      ..height = h;

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
    int i = 0;

    for (Line line in lines) {
      double lineBottom = offsetTop + line.height!;
      if (tapY < lineBottom) {
        currLineIndex = i;
        break;
      }

      offsetTop += line.height!;
      i++;
    }
  }
}