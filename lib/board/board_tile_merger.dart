import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/multi_tile.dart';
import 'package:game_2048/board/tile.dart';
import 'package:game_2048/two_dimens_array.dart';
import 'package:uuid/uuid.dart';

class BoardTileMerger {
  final uuid = const Uuid();

  MergeResult merge(Board board) {
    final newArray = TwoDimensArray(HashMap());
    int points = 0;
    board.array.items.forEach((key, value) {
      if (!value.isSingle) {
        final merged = _mergeTiles(value.tiles);
        points += merged.value;
        newArray.put(key.intX, key.intY, MultiTile.single(merged));
      } else {
        newArray.put(key.intX, key.intY, value);
      }
    });

    return MergeResult(Board(newArray), points);
  }

  Tile _mergeTiles(List<Tile> tiles) {
    final Tile tile1 = tiles[0];
    final Tile tile2 = tiles[1];
    final newId = uuid.v1();
    final mergedTile = Tile(newId, tile1.value + tile2.value);

    return mergedTile;
  }
}

class MergeResult extends Equatable {
  final Board board;
  final int points;

  const MergeResult(this.board, this.points);

  @override
  List<Object?> get props => [board, points];
}