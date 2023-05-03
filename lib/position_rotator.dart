import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/board_item.dart';
import 'package:game_2048/old/old_board_rotator.dart';
import 'package:game_2048/model/position.dart';

// class PositionRotator {
//   final BoardRotator _boardRotator = BoardRotator();
//
//   Position rotate(Position position) {
//     final board = _positionToBoard(position);
//
//     final newBoard = _boardRotator.rotate(board);
//
//     return _boardToPosition(newBoard);
//   }
//
//   Board _positionToBoard(Position position) {
//     final items = <BoardItem>[];
//     items.add(BoardItem(position, -1));
//     return Board.fromBoardItems(items);
//   }
//
//   Position _boardToPosition(Board board) {
//     final boardItem = board.items.firstWhere((element) => element.value == -1);
//     return boardItem.position;
//   }
// }