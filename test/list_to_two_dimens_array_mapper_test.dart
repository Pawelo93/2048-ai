import 'package:flutter_test/flutter_test.dart';
import 'package:game_2048/board/tile/multi_tile.dart';
import 'package:game_2048/board/tile/tile.dart';
import '../lib/board/util/list_to_two_dimens_array_mapper.dart';
import 'package:game_2048/board/util/position.dart';
import 'package:game_2048/board/util/two_dimens_array.dart';

void main() {
  test('mapper test', () {
    final List<List<Tile>> tiles = [
      [], [], [], [Tile('1', 1)],
      [], [], [Tile('2', 2)], [],
      [], [Tile('3', 3)], [], [],
      [Tile('4', 4)], [], [], [],
    ];
    final result = TwoDimensArray(
      {
        Position.int(3, 0): MultiTile.single(Tile('1', 1)),
        Position.int(2, 1): MultiTile.single(Tile('2', 2)),
        Position.int(1, 2): MultiTile.single(Tile('3', 3)),
        Position.int(0, 3): MultiTile.single(Tile('4', 4)),
      },
    );

    expect(ListToTwoDimensArrayMapper.map(tiles), result);
  });
}