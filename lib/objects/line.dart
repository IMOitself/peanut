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