import 'package:equatable/equatable.dart';
import 'package:game_2048/board/tile/positioned_tile.dart';
import 'package:game_2048/board/util/two_dimens_array.dart';

class Board extends Equatable {
  final TwoDimensArray array;

  const Board(this.array);

  @override
  List<Object?> get props => [array];

  List<PositionedTile> toPositionedTiles() {
    return array.items.entries
        .map((entry) => entry.value.tiles
            .map((e) => PositionedTile(e.id, entry.key, e.value))
            .toList())
        .expand((element) => element)
        .toList();
  }

  int getScore() {
    return array.items.values
        .map((e) => e.firstOrNull)
        .where((element) => element != null)
        .map((e) => _calculate(e!.value))
        .reduce((value, element) => value + element);
  }

  int _calculate(int value) {
    if (value == 4) {
      return 4;
    } else if (value == 8) {
      return 16;
    } else if (value > 8) {
      final beforeValue = value ~/ 2;
      return (2 * _calculate(beforeValue) + value);
    }

    return 0;
  }

  @override
  String toString() {
    String table = '\n';
    for (var y = 0; y < 4; y++) {
      for (var x = 0; x < 4; x++) {
        table += '[${array.get(x, y)?.firstOrNull?.value ?? '-'}]';
      }
      table += '\n';
    }
    return table;
  }
}
