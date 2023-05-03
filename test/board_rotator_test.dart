import 'package:flutter_test/flutter_test.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/board_rotator.dart';
import 'package:game_2048/board/multi_tile.dart';
import 'package:game_2048/board/row/row.dart';
import 'package:game_2048/board/tile.dart';
import 'package:game_2048/list_to_two_dimens_array_mapper.dart';
import 'package:game_2048/two_dimens_array.dart';

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

  // test('rotate test 1', () {
  //   final array = TwoDimensArrayMultiTile();
  //   array.put(0, 0, MultiTile([Tile('1', 1)]);
  //       Row([[Tile('1', 1)], [], [], []]),
  //   Row([[], [Tile('2', 2)], [], []]),
  //   Row([[], [], [Tile('3', 3)], []]),
  //   Row([[], [], [], [Tile('4', 4)]]),
  //   const board = Board(array);
  //
  //   const rotatedBoard = Board([
  //     Row([[], [], [], [Tile('1', 1)]]),
  //     Row([[], [], [Tile('2', 2)], []]),
  //     Row([[], [Tile('3', 3)], [], []]),
  //     Row([[Tile('4', 4)], [], [], []]),
  //   ]);
  //   expect(boardRotator.rotate(board), rotatedBoard);
  // });
}