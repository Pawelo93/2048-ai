import 'package:equatable/equatable.dart';
import 'package:game_2048/model/position.dart';

class Board extends Equatable {
  List<BoardItem> items = [];

  Board(this.items);

  static fromList(List<List<int>> list) {
    final items = <BoardItem>[];
    for (var y = 0; y < list.length; y++) {
      for (var x = 0; x < list[0].length; x++) {
        final value = list[y][x];
        items.add(BoardItem(Position(x.toDouble(), y.toDouble()), value));
      }
    }
    return Board(items);
  }

  @override
  List<Object?> get props => [items];

  List<List<int>> asList() {
    final list = <List<int>>[];
    for (var y = 0; y < 4; y++) {
      list.add([]);
      for (var x = 0; x < 4; x++) {
        list[y].add(0);

        for (var element in items) {
          if (element.position == Position(x.toDouble(), y.toDouble())) {
            list[y][x] = element.value;
            break;
          }
        }
      }
    }
    return list;
  }
}

class BoardItem extends Equatable {
  final Position position;
  final int value;

  const BoardItem(this.position, this.value);

  @override
  List<Object?> get props => [position, value];
}