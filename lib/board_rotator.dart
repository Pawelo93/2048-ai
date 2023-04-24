import 'package:game_2048/board.dart';
import 'package:game_2048/model/position.dart';

class BoardRotator {
  Board rotate(Board oldBoard) {
    final newItems = <BoardItem>[];

    final rows = oldBoard.asList();
    double newX = 0;
    double newY = 0;
    for (var x = 0; x < 4; x++) {
      newX = 0;
      for (var y = 3; y >= 0; y--) {
        final value = rows[y][x];
        newItems.add(BoardItem(Position(newX, newY), value));
        newX++;
      }
      newY++;
    }

    return Board(newItems);
  }
}
