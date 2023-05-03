import 'package:flutter_test/flutter_test.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/board_item.dart';
import 'package:game_2048/model/position.dart';

// void main() {
//   test('board 1', () {
//     Board board = Board.fromBoardItems([
//       const BoardItem(Position(1, 1), 2),
//       const BoardItem(Position(2, 2), 4),
//     ]);
//
//     final items = [
//       BoardItem(Position(0.0, 0.0), 0), BoardItem(Position(1.0, 0.0), 0), BoardItem(Position(2.0, 0.0), 0), BoardItem(Position(3.0, 0.0), 0),
//
//       BoardItem(Position(0.0, 1.0), 0), BoardItem(Position(1.0, 1.0), 2), BoardItem(Position(2.0, 1.0), 0), BoardItem(Position(3.0, 1.0), 0),
//
//       BoardItem(Position(0.0, 2.0), 0), BoardItem(Position(1.0, 2.0), 0), BoardItem(Position(2.0, 2.0), 4), BoardItem(Position(3.0, 2.0), 0),
//
//       BoardItem(Position(0.0, 3.0), 0), BoardItem(Position(1.0, 3.0), 0), BoardItem(Position(2.0, 3.0), 0), BoardItem(Position(3.0, 3.0), 0),
//     ];
//
//     expect(board.items, items);
//   });
// }