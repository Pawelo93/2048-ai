import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:game_2048/board.dart';
import 'package:game_2048/board_view.dart';
import 'package:game_2048/model/position.dart';

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

  void update(List<AnimatingBoardItem> boardItems) {
    items = boardItems;
    // items = items.map((item) {
    //   if (item.currentPosition == boardItem.currentPosition) {
    //     return boardItem;
    //   }
    //
    //   return item;
    // }).toList();
    // items = [];
    // add(boardItem);
  }

  void animate(double dt) {
    items = items.map((item) {
      final x = (item.toPosition.x - item.fromPosition.x).abs();
      final y = (item.toPosition.y - item.fromPosition.y).abs();

      return AnimatingBoardItem(Position(item.fromPosition.x - x * dt, item.fromPosition.y + y * dt), item.fromPosition, item.toPosition, item.value);
    }).toList();
  }

  void endAnimation(Board newBoard) {
    items = newBoard.items.map((item) {
      return AnimatingBoardItem(item.position, item.position, item.position, item.value);
    }).toList();
  }

  Board toBoard() {
    final newItems = items.map((item) => BoardItem(item.currentPosition, item.value)).toList();
    return Board(newItems);
  }
}

class AnimatingBoardItem extends Equatable {
  final Position currentPosition;
  final Position fromPosition;
  final Position toPosition;
  final int value;

  const AnimatingBoardItem(this.currentPosition, this.fromPosition, this.toPosition, this.value);

  @override
  List<Object?> get props => [currentPosition, fromPosition, toPosition, value];
}
