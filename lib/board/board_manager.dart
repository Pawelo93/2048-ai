import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/board_rotator.dart';
import 'package:game_2048/board/board_transformer.dart';

class BoardManager {
  final BoardTransformer _boardTransformer = BoardTransformer();
  final BoardRotator _boardRotator = BoardRotator();

  Board transform(Board board) {
    return _boardTransformer.transform(board);
  }

  Board rotate(Board board, int counter) {
    final rotatedBoard = _boardRotator.rotate(board);
    if (counter == 1) {
      return rotatedBoard;
    } else {
      return rotate(board, counter - 1);
    }
  }

}