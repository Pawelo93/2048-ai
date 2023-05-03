import 'package:game_2048/board/row/row.dart';
import 'package:game_2048/board/tile.dart';

class SingleRowTransformer {
  Row transform(Row row) {
    final tiles = row.tiles;

    final Tile? tile1 = tiles[0];
    final Tile? tile2 = tiles[1];
    final Tile? tile3 = tiles[2];
    final Tile? tile4 = tiles[3];

    int tilesCount = getTilesCount(tiles);

    if (tilesCount == 0) {
      return row;
    }

    if (tilesCount == 1) {
      if (tile4 != null) {
        return Row({
          0: tile4,
        });
      }

      if (tile3 != null) {
        return Row({
          0: tile3,
        });
      }

      if (tile2 != null) {
        return Row({
          0: tile2,
        });
      }
    }

    if (tilesCount == 2) {
      List<Tile> twoTiles = tiles.values.where((element) => element != null).map((e) => e as Tile).toList();
      if (twoTiles[0].value == twoTiles[1].value) {
        // Row({
        //   0: twoTiles[0],
        // });
      } else {

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

  int getTilesCount(Map<int, Tile?> tiles) {
    return tiles.values.where((element) => element != null).length;
  }
}