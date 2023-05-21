import 'package:flutter_test/flutter_test.dart';
import 'package:game_2048/board/tile/multi_tile.dart';
import 'package:game_2048/board/row/row.dart';
import 'package:game_2048/board/row/single_row_transformer.dart';
import 'package:game_2048/board/tile/tile.dart';

void main() {
  final SingleRowTransformer singleRowTransformer = SingleRowTransformer();

  // group('exception', () {
  //   test('test 1', () {
  //     const row = Row([
  //       [], [], [], [Tile('1', 2), Tile('1', 2)],
  //     ]);
  //
  //     expect(() => singleRowTransformer.transform(row), throwsException);
  //   });
  // });

  group('single tile', () {
    test('test 1', () {
      final row = Row({
        3: MultiTile.single(Tile('1', 2)),
      });
      final afterTransformation = Row({
        0: MultiTile.single(Tile('1', 2)),
      });

      expect(singleRowTransformer.transform(row), afterTransformation);
    });

    test('test 2', () {
      final row = Row({
        2: MultiTile.single(Tile('1', 2)),
      });
      final afterTransformation = Row({
        0: MultiTile.single(Tile('1', 2)),
      });

      expect(singleRowTransformer.transform(row), afterTransformation);
    });

    test('test 3', () {
      final row = Row({
        1: MultiTile.single(Tile('1', 2)),
      });
      final afterTransformation = Row({
        0: MultiTile.single(Tile('1', 2)),
      });

      expect(singleRowTransformer.transform(row), afterTransformation);
    });

    test('test 4', () {
      final row = Row({
        0: MultiTile.single(Tile('1', 2)),
      });
      final afterTransformation = Row({
        0: MultiTile.single(Tile('1', 2)),
      });

      expect(singleRowTransformer.transform(row), afterTransformation);
    });
  });

  group('two tiles', () {

  });
}
