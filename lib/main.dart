import 'package:flutter/material.dart';
import 'screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ScrumGlossary(),
      ),
    );
  }
}
