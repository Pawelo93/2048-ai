import 'package:flutter_test/flutter_test.dart';
import 'package:game_2048/board.dart';
import 'package:game_2048/board_rotator.dart';

void main() {
  final boardFlipper = BoardRotator();

  test('flip 1', () {
    final startBoard = Board.fromList(
      [
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 10, 11, 12],
        [13, 14, 15, 16],
      ],
    );

    final endBoard = Board.fromList(
      [
        [13, 9, 5, 1],
        [14, 10, 6, 2],
        [15, 11, 7, 3],
        [16, 12, 8, 4],
      ],
    );

    final result = boardFlipper.rotate(startBoard);
    expect(result, endBoard);
  });

  test('flip 2', () {
    final startBoard = Board.fromList(
      [
        [2, 0, 0, 0],
        [2, 4, 0, 0],
        [2, 0, 4, 0],
        [2, 0, 0, 4],
      ],
    );

    final endBoard = Board.fromList(
      [
        [2, 2, 2, 2],
        [0, 0, 4, 0],
        [0, 4, 0, 0],
        [4, 0, 0, 0],
      ],
    );

    final result = boardFlipper.rotate(startBoard);
    expect(result, endBoard);
  });
}