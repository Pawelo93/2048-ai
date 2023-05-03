import 'dart:collection';

import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/multi_tile.dart';
import 'package:game_2048/board/row/row.dart';
import 'package:game_2048/board/row/single_row_transformer.dart';
import 'package:game_2048/board/tile.dart';
import 'package:game_2048/two_dimens_array.dart';

class BoardTransformer {
  final SingleRowTransformer _singleRowTransformer = SingleRowTransformer();

  Board transform(Board board) {
    final List<Row> rows = [];
    for (var y = 0; y < 4; y++) {
      rows.add(_transformRow(board.array.getRow(y)));
    }

    final TwoDimensArray newArray = TwoDimensArray(HashMap());
    for (var y = 0; y < 4; y++) {
      final row = rows[y];
      for (var x = 0; x < 4; x++) {
        final tile = row.tiles[x];
        if (tile != null) {
          newArray.put(x, y, tile);
        }
      }
    }

    return Board(newArray);
  }

  Row _transformRow(List<MultiTile> tiles) {
    if(tiles.where((element) => element.tiles.length > 1).isNotEmpty) {
      throw Exception('Wrong state, call merge before transformation!');
    }
    final singles = tiles.map((e) => e.firstOrNull).toList();
    final row = Row(
      {
        0: getTile(0, singles),
        1: getTile(1, singles),
        2: getTile(2, singles),
        3: getTile(3, singles),
      }
    );
    final transformedRow = _singleRowTransformer.transform(row);

    return transformedRow;
  }

  MultiTile? getTile(int index, List<Tile?> tiles) {
    if (tiles.length > index) {
      final tile = tiles[index];
      if (tile != null) {
        return MultiTile.single(tile);
      }
    }

    return null;
  }
}