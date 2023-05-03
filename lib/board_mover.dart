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

  Board moveDown(Board board) {
    return board;
  }

  Board moveRight(Board board) {
    return board;
  }

  // BoardTransformerOutput moveRight(Board board) {
  //   final rotatedBoard = boardManager.rotate(board, 2);
  //
  //   final rotation1 = BoardRotator().rotate(board);
  //   final rotation2 =  BoardRotator().rotate(rotation1);
  //
  //   final transformation = BoardTransformer().transform(rotation2);
  //   final reRotation1 =  BoardRotator().rotate(transformation.newBoard);
  //   final reRotation2 =  BoardRotator().rotate(reRotation1);
  //
  //   final PositionRotator positionRotator = PositionRotator();
  //   final transforms = transformation.transforms
  //       .map((e) => MoveTransform(positionRotator.rotate(e.from), positionRotator.rotate(e.to), e.value))
  //       .map((e) => MoveTransform(positionRotator.rotate(e.from), positionRotator.rotate(e.to), e.value))
  //       .toList();
  //
  //   return BoardTransformerOutput(reRotation2, board, transforms);
  // }
  //
  // BoardTransformerOutput moveDown(Board board) {
  //   final rotatedBoard = boardManager.rotate(board, 1);
  //
  //   final rotation1 = BoardRotator().rotate(board);
  //
  //   final transformation = BoardTransformer().transform(rotation1);
  //   final reRotation1 =  BoardRotator().rotate(transformation.newBoard);
  //   final reRotation2 =  BoardRotator().rotate(reRotation1);
  //   final reRotation3 =  BoardRotator().rotate(reRotation2);
  //
  //   final PositionRotator positionRotator = PositionRotator();
  //   final transforms = transformation.transforms
  //       .map((e) => MoveTransform(positionRotator.rotate(e.from), positionRotator.rotate(e.to), e.value))
  //       .map((e) => MoveTransform(positionRotator.rotate(e.from), positionRotator.rotate(e.to), e.value))
  //       .map((e) => MoveTransform(positionRotator.rotate(e.from), positionRotator.rotate(e.to), e.value))
  //       .toList();
  //
  //   return BoardTransformerOutput(reRotation3, board, transforms);
  // }
}