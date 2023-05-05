import 'dart:math';

import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/multi_tile.dart';
import 'package:game_2048/board/tile.dart';
import 'package:game_2048/model/position.dart';
import 'package:game_2048/two_dimens_array.dart';
import 'package:uuid/uuid.dart';

class RandomTileAdder {
  final Random random = Random(1);
  final Uuid uuid = const Uuid();

  Board addRandom(Board board) {
    final newArray = TwoDimensArray(board.array.items);
    do {
      final randomX = random.nextInt(4);
      final randomY = random.nextInt(4);
      final tempPos = Position.int(randomX, randomY);

      if (board.array.items[tempPos] == null) {
        final id = uuid.v1();
        final randomValue = random.nextInt(4) < 3 ? 2 : 4;
        newArray.put(tempPos.intX, tempPos.intY, MultiTile.single(Tile(id, randomValue)));
        return Board(newArray);
      }
    } while (true);
  }
}