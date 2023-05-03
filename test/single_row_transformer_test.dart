import 'package:flutter_test/flutter_test.dart';
import 'package:game_2048/board/row/row.dart';
import 'package:game_2048/board/row/single_row_transformer.dart';
import 'package:game_2048/board/tile.dart';

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
      const row = Row({
        3: Tile('1', 2),
      });
      const afterTransformation = Row({
        0: Tile('1', 2),
      });

      expect(singleRowTransformer.transform(row), afterTransformation);
    });

    test('test 2', () {
      const row = Row({
        2: Tile('1', 2),
      });
      const afterTransformation = Row({
        0: Tile('1', 2),
      });

      expect(singleRowTransformer.transform(row), afterTransformation);
    });

    test('test 3', () {
      const row = Row({
        1: Tile('1', 2),
      });
      const afterTransformation = Row({
        0: Tile('1', 2),
      });

      expect(singleRowTransformer.transform(row), afterTransformation);
    });

    test('test 4', () {
      const row = Row({
        0: Tile('1', 2),
      });
      const afterTransformation = Row({
        0: Tile('1', 2),
      });

      expect(singleRowTransformer.transform(row), afterTransformation);
    });
  });
}
