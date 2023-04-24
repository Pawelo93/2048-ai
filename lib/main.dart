import 'package:flutter/material.dart';
import 'package:game_2048/animated_board_view.dart';
import 'package:game_2048/animating_board.dart';
import 'package:game_2048/model/position.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimatingBoard board = AnimatingBoard()
    ..add(AnimatingBoardItem(Position(1, 1), Position(1, 1), Position(1, 1), 2))
    ..add(AnimatingBoardItem(Position(3, 1), Position(3, 1), Position(3, 1), 2))
    ..add(AnimatingBoardItem(Position(2, 3), Position(2, 3), Position(2, 3), 2))
    ..add(AnimatingBoardItem(Position(1, 0), Position(1, 0), Position(1, 0), 2));

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          AnimatedBoardView(animatingBoard: board),
        ],
      ),
    );
  }
}

