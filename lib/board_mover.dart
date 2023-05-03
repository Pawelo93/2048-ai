import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/board_manager.dart';

class BoardMover {

  final BoardManager boardManager = BoardManager();

  Board moveLeft(Board board) {
    return boardManager.transform(board);
  }

  Board moveTop(Board board) {
    final rotatedBoard = boardManager.rotate(board, 3);
    final transformedBoard = boardManager.transform(rotatedBoard);
    final backRotatedBoard = boardManager.rotate(transformedBoard, 1);

    return backRotatedBoard;
  }

  Board moveRight(Board board) {
    final rotatedBoard = boardManager.rotate(board, 2);
    final transformedBoard = boardManager.transform(rotatedBoard);
    final backRotatedBoard = boardManager.rotate(transformedBoard, 2);

    return backRotatedBoard;
  }

  Board moveDown(Board board) {
    final rotatedBoard = boardManager.rotate(board, 1);
    final transformedBoard = boardManager.transform(rotatedBoard);
    final backRotatedBoard = boardManager.rotate(transformedBoard, 3);

    return backRotatedBoard;
  }
}