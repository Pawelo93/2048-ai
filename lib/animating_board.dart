import 'dart:math';

import 'package:game_2048/board.dart';
import 'package:game_2048/board_view.dart';

class AnimatingBoard {
  // List<List<int>> _board = [
  //   [0, 0, 0, 0],
  //   [0, 0, 0, 0],
  //   [0, 0, 0, 0],
  //   [0, 0, 0, 0],
  // ];
  List<AnimatingBoardItem> items = [];

  AnimatingBoard();


  void add(AnimatingBoardItem item) {
    items.add(item);
  }

  // bool hasElementAt(double x, double y) {
  //   try {
  //     items.firstWhere((element) => element.currentPosition.x == x && element.currentPosition.y == y);
  //     return true;
  //   } catch(e) {
  //     return false;
  //   }
  // }

  void update(AnimatingBoardItem boardItem) {
    items = [];
    add(boardItem);
  }

  void animate(double dt) {
    items = items.map((item) {
      final y = (item.toPosition.y - item.fromPosition.y).abs();

      return AnimatingBoardItem(Position(item.currentPosition.x, item.fromPosition.y + y * dt), item.fromPosition, item.toPosition, item.value);
    }).toList();
  }

  void endAnimation() {
    items = items.map((item) {
      return AnimatingBoardItem(item.toPosition, item.toPosition, item.toPosition, item.value);
    }).toList();
  }

  Board toBoard() {
    final newItems = items.map((item) => BoardItem(item.currentPosition)).toList();

    return Board(newItems);
  }

  // BoardItem get(int x, int y) {
  //   return items.firstWhere((item) => item.currentPosition.x == x && item.currentPosition.y == y);
  // }

  // void set(List<List<int>> board) {
  //   _board = board;
  // }
  //
  // int get(int x, int y) {
  //   return _board[y][x];
  // }
}

class AnimatingBoardItem {
  final Position currentPosition;
  final Position fromPosition;
  final Position toPosition;
  final int value;

  AnimatingBoardItem(this.currentPosition, this.fromPosition, this.toPosition, this.value);

  @override
  String toString() {
    return 'AnimatingBoardItem{currentPosition: $currentPosition, fromPosition: $fromPosition, toPosition: $toPosition, value: $value}';
  }
}
