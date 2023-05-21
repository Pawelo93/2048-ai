import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/tile/multi_tile.dart';
import 'package:game_2048/board/tile/tile.dart';
import 'package:game_2048/board/util/position.dart';
import 'package:game_2048/board/util/two_dimens_array.dart';
import 'package:uuid/uuid.dart';

class TileAdder {
  final Uuid uuid = const Uuid();

  Board addTile(Board board, int x, int y, int value) {
    final newArray = TwoDimensArray(Map.of(board.array.items));
    final tempPos = Position.int(x, y);

    if (board.array.items[tempPos] == null) {
      final id = uuid.v1();
      newArray.put(tempPos.intX, tempPos.intY, MultiTile.single(Tile(id, value)));
      return Board(newArray);
    } else {
      throw Exception("Position x: $x y: $y already taken");
    }
  }
}