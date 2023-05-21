import 'dart:collection';

import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/util/two_dimens_array.dart';

class BoardRotator {
  Board rotate(Board board) {
    final TwoDimensArray newArray = TwoDimensArray(HashMap());

    int newX = 0;
    int newY = 0;
    for (var x = 0; x < 4; x++) {
      newX = 0;
      for (var y = 3; y >= 0; y--) {
        final value = board.array.get(x, y);
        if (value != null) {
          newArray.put(newX, newY, value);
        }
        newX++;
      }
      newY++;
    }

    return Board(newArray);
  }
}
