import 'package:flutter/material.dart';
import 'package:xo_game/pages/GamePage.dart';
import 'package:xo_game/pages/HomePage.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false, 
    );
  }
}

