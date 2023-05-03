import 'dart:collection';

import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/board_rotator.dart';
import 'package:game_2048/board/board_transformer.dart';
import 'package:game_2048/board/multi_tile.dart';
import 'package:game_2048/board/tile.dart';
import 'package:game_2048/two_dimens_array.dart';
import 'package:uuid/uuid.dart';

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
      return rotate(rotatedBoard, counter - 1);
    }
  }

  Board merge(Board board) {
    final newArray = TwoDimensArray(HashMap());
    board.array.items.forEach((key, value) {
      if (!value.isSingle) {
        final merged = mergeTiles(value.tiles);
        newArray.put(key.intX, key.intY, MultiTile.single(merged));
      } else {
        newArray.put(key.intX, key.intY, value);
      }
    });

    return Board(newArray);
  }

  Tile mergeTiles(List<Tile> tiles) {
    final Tile tile1 = tiles[0];
    final Tile tile2 = tiles[1];
    final newId = const Uuid().v1();
    final mergedTile = Tile(newId, tile1.value * tile2.value);

    return mergedTile;
  }

}