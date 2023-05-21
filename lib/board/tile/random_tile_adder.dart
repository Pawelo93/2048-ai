import 'dart:math';

import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/tile/tile_adder.dart';
import 'package:game_2048/board/util/position.dart';

class RandomTileAdder {
  final Random random = Random(1);
  final TileAdder _tileAdder = TileAdder();

  Board addRandom(Board board) {
    do {
      final randomX = random.nextInt(4);
      final randomY = random.nextInt(4);
      final tempPos = Position.int(randomX, randomY);

      if (board.array.items[tempPos] == null) {
        final randomValue = random.nextInt(4) < 3 ? 2 : 4;

        return _tileAdder.addTile(board, randomX, randomY, randomValue);
      }
    } while (true);
  }
}