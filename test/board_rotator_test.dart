import 'package:flutter_test/flutter_test.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/board_rotator.dart';
import 'package:game_2048/board/tile/tile.dart';
import '../lib/board/util/list_to_two_dimens_array_mapper.dart';

void main() {
  final BoardRotator boardRotator = BoardRotator();
  test('rotate test 1', () {
    final tiles = ListToTwoDimensArrayMapper.map([
      [Tile('1', 1)], [], [], [],
      [], [Tile('2', 2)], [], [],
      [], [], [Tile('3', 3)], [],
      [], [], [], [Tile('4', 4)],
    ]);
    final board = Board(tiles);

    final rotatedTiles = ListToTwoDimensArrayMapper.map([
      [], [], [], [Tile('1', 1)],
      [], [], [Tile('2', 2)], [],
      [], [Tile('3', 3)], [], [],
      [Tile('4', 4)], [], [], [],
    ]);
    final rotatedBoard = Board(rotatedTiles);

    expect(boardRotator.rotate(board), rotatedBoard);
  });

  test('rotate test 2', () {
    final tiles = ListToTwoDimensArrayMapper.map([
      [], [], [], [Tile('1', 1)],
      [], [], [Tile('2', 2)], [],
      [], [Tile('3', 3)], [], [],
      [Tile('4', 4)], [], [], [],
    ]);
    final board = Board(tiles);

    final rotatedTiles = ListToTwoDimensArrayMapper.map([
      [Tile('4', 4)], [], [], [],
      [], [Tile('3', 3)], [], [],
      [], [], [Tile('2', 2)], [],
      [], [], [], [Tile('1', 1)],
    ]);
    final rotatedBoard = Board(rotatedTiles);

    expect(boardRotator.rotate(board), rotatedBoard);
  });
}