import 'package:flutter_test/flutter_test.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/multi_tile.dart';
import 'package:game_2048/board/positioned_tile.dart';
import 'package:game_2048/board/row/row.dart';
import 'package:game_2048/board/tile.dart';
import 'package:game_2048/model/position.dart';
import 'package:game_2048/two_dimens_array.dart';

void main() {
  group('create from positioned tile', () {
    // test('test 1', () {
    //   final board = Board.fromPositionalTiles([
    //     const PositionedTile('1', Position(1, 1), 2),
    //     const PositionedTile('2', Position(2, 3), 2),
    //   ]);
    //
    //   const expectedBoard = Board(
    //     [
    //       Row([[], [], [], []]),
    //       Row([[], [Tile('1', 2)], [], []]),
    //       Row([[], [], [], []]),
    //       Row([[], [], [Tile('2', 2)], []]),
    //     ],
    //   );
    //
    //   expect(board, expectedBoard);
    // });

    // test('test 2', () {
    //   final board = Board.fromPositionalTiles([
    //     const PositionedTile('1', Position(1, 1), 4),
    //     const PositionedTile('2', Position(2, 3), 2),
    //     const PositionedTile('3', Position(2, 3), 2),
    //   ]);
    //
    //   const expectedBoard = Board(
    //     [
    //       Row([[], [], [], []]),
    //       Row([[], [Tile('1', 4)], [], []]),
    //       Row([[], [], [], []]),
    //       Row([[], [], [Tile('2', 2), Tile('3', 2)], []]),
    //     ],
    //   );
    //
    //   expect(board, expectedBoard);
    // });


  });

  group('transform to positioned tile', () {

    test('test 1', () {
      final board = Board(TwoDimensArray({
        Position.int(1, 1): MultiTile.single(Tile('1', 2)),
        Position.int(3, 2): MultiTile.single(Tile('1', 2)),
      }));

      final positionedTiles = [
        const PositionedTile('1', Position(1, 1), 2),
        const PositionedTile('2', Position(3, 2), 2),
      ];

      expect(board.toPositionedTiles(), positionedTiles);
    });


    // test('test 2', () {
    //   const board = Board(
    //     [
    //       Row([[], [], [], []]),
    //       Row([[], [Tile('1', 4)], [], []]),
    //       Row([[], [], [], []]),
    //       Row([[], [], [Tile('2', 2), Tile('3', 2)], []]),
    //     ],
    //   );
    //
    //   final positionedTiles = [
    //     const PositionedTile('1', Position(1, 1), 4),
    //     const PositionedTile('2', Position(2, 3), 2),
    //     const PositionedTile('3', Position(2, 3), 2),
    //   ];
    //
    //   expect(board.toPositionedTiles(), positionedTiles);
    // });
  });
}
