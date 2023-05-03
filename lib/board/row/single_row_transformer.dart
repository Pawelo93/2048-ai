import 'package:game_2048/board/multi_tile.dart';
import 'package:game_2048/board/row/row.dart';
import 'package:game_2048/board/tile.dart';

class SingleRowTransformer {
  Row transform(Row row) {
    final tiles = row.tiles;

    final Tile? tile1 = tiles[0]?.firstOrNull;
    final Tile? tile2 = tiles[1]?.firstOrNull;
    final Tile? tile3 = tiles[2]?.firstOrNull;
    final Tile? tile4 = tiles[3]?.firstOrNull;

    int tilesCount = getTilesCount(tiles);

    if (tilesCount == 0) {
      return row;
    }

    if (tilesCount == 1) {
      if (tile4 != null) {
        return Row({
          0: MultiTile.single(tile4),
        });
      }

      if (tile3 != null) {
        return Row({
          0: MultiTile.single(tile3),
        });
      }

      if (tile2 != null) {
        return Row({
          0: MultiTile.single(tile2),
        });
      }
    }

    if (tilesCount == 2) {
      List<Tile> twoTiles = tiles.values.where((element) => element != null && element.firstOrNull != null).map((e) => e?.firstOrNull).map((e) => e as Tile).toList();
      final first = twoTiles[0];
      final second = twoTiles[1];

      if (first.value == second.value) {
        return Row({
          0: MultiTile([first, second]),
        });
      } else {
        return Row({
          0: MultiTile.single(first),
          1: MultiTile.single(second),
        });
      }
    }

    return row;
  }

  Tile? getFirst(List<Tile> tiles) {
    if (tiles.isNotEmpty) {
      return tiles[0];
    } else {
      return null;
    }
  }

  int getTilesCount(Map<int, MultiTile?> tiles) {
    return tiles.values.where((element) => element != null).length;
  }
}