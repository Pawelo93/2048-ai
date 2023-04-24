import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_2048/board.dart';
import 'package:game_2048/model/position.dart';

const Color color2 = Color(0xFFeee4da);
const Color color4 = Color(0xFFeee1ca);
const Color color8 = Color(0xFFf3b279);
const Color color16 = Color(0xFFf69564);
const Color color32 = Color(0xFFf77c5f);
const Color color64 = Color(0xFFf75f3c);

class BoardView extends StatelessWidget {
  const BoardView({Key? key, required this.board}) : super(key: key);

  final Board board;

  @override
  Widget build(BuildContext context) {
    final items = <Position>[];
    for (var i = 0; i < 4; i++) {
      for (var j = 0; j < 4; j++) {
        items.add(Position(j.toDouble(), i.toDouble()));
      }
    }

    final List<BoardItem> movingItems = board.items;

    final boardWidth = MediaQuery.of(context).size.width / 2;
    final boardHeight = boardWidth;

    const gap = 12.0;
    final width = (boardWidth - 5 * gap) / 4;
    final height = width;

    return Container(
      width: boardWidth,
      height: boardHeight,
      padding: const EdgeInsets.all(gap),
      decoration: BoxDecoration(
        color: const Color(0xFFbcac9f),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          ...items.map((item) {
            return Positioned(
              left: item.x * (width + gap),
              top: item.y * (height + gap),
              width: width,
              height: height,
              child: Container(
                decoration: BoxDecoration(
                  color: getItemColor(0),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
          ...movingItems.map((item) {
            return Positioned(
              left: item.position.x * (width + gap),
              top: item.position.y * (height + gap),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                switchInCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  final tween = Tween(begin: 0.6, end: 1.0)
                      .chain(CurveTween(curve: Curves.ease));
                  return ScaleTransition(
                    scale: tween.animate(animation),
                    child: child,
                  );
                },
                child: Container(
                  key: ValueKey(item.value),
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: getItemColor(item.value),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      item.value.toString(),
                      style: const TextStyle(
                        color: Color(0xFF776e65),
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Color getItemColor(int value) {
    switch (value) {
      case 2:
        return color2;
      case 4:
        return color4;
      case 8:
        return color8;
      case 16:
        return color16;
      case 32:
        return color32;
      default:
        return const Color(0xFFccc1b4);
    }
  }
}
