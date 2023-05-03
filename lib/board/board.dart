import 'package:equatable/equatable.dart';
import 'package:game_2048/board/positioned_tile.dart';
import 'package:game_2048/two_dimens_array.dart';

class Board extends Equatable {
  final TwoDimensArray array;

  const Board(this.array);

  @override
  List<Object?> get props => [array];

  List<PositionedTile> toPositionedTiles() {
    return array.items.entries
        .map((entry) => entry.value.tiles
            .map((e) => PositionedTile(e.id, entry.key, e.value))
            .toList())
        .expand((element) => element)
        .toList();
  }

// List<Tile> asList() {
//   List<Tile> positionedTiles = [];
//   for (var row in rows) {
//     final tiles = row.tiles;
//     for (var x = 0; x < 4; x++) {
//       final currentTiles = tiles[x];
//       if (currentTiles.isNotEmpty) {
//         for (var currentTile in currentTiles) {
//           positionedTiles.add(Tile(currentTile.id, currentTile.value));
//         }
//       }
//     }
//   }
//
//   return positionedTiles;
// }

// static fromPositionalTiles(List<PositionedTile> positionedTiles) {
//
//   final List<MultiTile> multiTiles = [];
//   for (var positionedTile in positionedTiles) {
//     // multiTiles.add(Mul)
//   }
// final List<Row> rows = [];
// for (var y = 0; y < 4; y++) {
//   rows.add(findRow(positionedTiles, y));
// }
// return Board(rows);
// }

// static Row findRow(List<PositionedTile> positionedTiles, int y) {
//   final Map<int, List<Tile>> innerTiles = {};
//
//   for (var x = 0; x < 4; x++) {
//     if(innerTiles[x] == null) {
//       innerTiles[x] = [];
//     }
//     final currentPosition = Position(x.toDouble(), y.toDouble());
//     for (var positionedTile in positionedTiles) {
//       if (positionedTile.position == currentPosition) {
//         innerTiles[x]?.add(Tile(positionedTile.id, positionedTile.value));
//       }
//     }
//   }
//
//   return Row(innerTiles.values.toList());
// }
}
