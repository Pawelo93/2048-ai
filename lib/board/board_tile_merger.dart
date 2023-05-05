import 'dart:collection';

import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/multi_tile.dart';
import 'package:game_2048/board/tile.dart';
import 'package:game_2048/two_dimens_array.dart';
import 'package:uuid/uuid.dart';

class BoardTileMerger {
  final uuid = const Uuid();

  Board merge(Board board) {
    final newArray = TwoDimensArray(HashMap());
    board.array.items.forEach((key, value) {
      if (!value.isSingle) {
        final merged = _mergeTiles(value.tiles);
        newArray.put(key.intX, key.intY, MultiTile.single(merged));
      } else {
        newArray.put(key.intX, key.intY, value);
      }
    });

    return Board(newArray);
  }

  Tile _mergeTiles(List<Tile> tiles) {
    final Tile tile1 = tiles[0];
    final Tile tile2 = tiles[1];
    final newId = uuid.v1();
    final mergedTile = Tile(newId, tile1.value + tile2.value);

    return mergedTile;
  }
}