import 'package:flutter/material.dart';
import 'editor.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var string = 'last\nrizzmas\ni\ngave\nyou\nmy\ngyatt\nbut\nthe\nvery\nnext\nday\ni\ngot\nfanum\ntax';

    return MaterialApp(
      home: SizedBox.expand(child: Editor(string)),
    );
  }
}