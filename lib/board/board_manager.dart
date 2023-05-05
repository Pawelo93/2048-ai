import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/board_rotator.dart';
import 'package:game_2048/board/board_tile_merger.dart';
import 'package:game_2048/board/board_transformer.dart';
import 'package:game_2048/board/random_tile_adder.dart';

class BoardManager {
  final BoardTransformer _boardTransformer = BoardTransformer();
  final BoardRotator _boardRotator = BoardRotator();
  final BoardTileMerger _boardTileMerger = BoardTileMerger();
  final RandomTileAdder _randomTileAdder = RandomTileAdder();

  Board transform(Board board) {
    return _boardTransformer.transform(board);
  }

  Board rotate(Board board, int counter) {
    final rotatedBoard = _boardRotator.rotate(board);
    if (counter == 1) {
      return rotatedBoard;
    } else {
      return rotate(rotatedBoard, counter - 1);
    }
  }

  Board merge(Board board) {
    return _boardTileMerger.merge(board);
  }

  Board addRandomTile(Board board) {
    return _randomTileAdder.addRandom(board);
  }
}
