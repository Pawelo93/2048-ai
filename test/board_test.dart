import 'package:flutter_test/flutter_test.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/tile/multi_tile.dart';
import 'package:game_2048/board/tile/positioned_tile.dart';
import 'package:game_2048/board/tile/tile.dart';
import 'package:game_2048/board/util/position.dart';
import 'package:game_2048/board/util/two_dimens_array.dart';

void main() {
  group('transform to positioned tile', () {

    test('test 1', () {
      final board = Board(TwoDimensArray({
        Position.int(1, 1): MultiTile.single(Tile('1', 2)),
        Position.int(3, 2): MultiTile.single(Tile('2', 2)),
      }));

      final positionedTiles = [
        const PositionedTile('1', Position(1, 1), 2),
        const PositionedTile('2', Position(3, 2), 2),
      ];

      expect(board.toPositionedTiles(), positionedTiles);
    });
  });
}
