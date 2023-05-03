import 'package:equatable/equatable.dart';
import 'package:game_2048/model/position.dart';
import 'package:game_2048/test_widget.dart';

class TestBoard extends Equatable {
  List<TestBoardItem> items = [];

  // static fromBoardItems(List<TestBoardItem> boardItems) {
  //   final items = <TestBoardItem>[];
  //   for (var y = 0; y < 4; y++) {
  //     for (var x = 0; x < 4; x++) {
  //       bool added = false;
  //       final currentPosition = Position(x.toDouble(), y.toDouble());
  //       for (var boardItem in boardItems) {
  //         if (boardItem.position == currentPosition) {
  //           items.add(boardItem);
  //           added = true;
  //           break;
  //         }
  //       }
  //       if (!added) {
  //         items.add(TestBoardItem(currentPosition, 0));
  //       }
  //     }
  //   }
  //   return TestBoard()..items = items;
  // }

  static fromList(List<List<List<Tile?>>> list) {
    final items = <TestBoardItem>[];
    for (var y = 0; y < list.length; y++) {
      for (var x = 0; x < list[0].length; x++) {
        final List<Tile> tiles = list[y][x]
            .where((element) => element != null)
            .map((e) => e as Tile)
            .toList();

        for (var tile in tiles) {
          items.add(
            TestBoardItem(
              tile.id,
              Position(x.toDouble(), y.toDouble()),
              tile.value,
            ),
          );
        }
      }
    }
    return TestBoard()..items = items;
  }

  List<List<int>> asList() {
    final list = <List<int>>[];
    for (var y = 0; y < 4; y++) {
      list.add([]);
      for (var x = 0; x < 4; x++) {
        list[y].add(0);

        for (var element in items) {
          if (element.position == Position(x.toDouble(), y.toDouble())) {
            list[y][x] = element.value;
            continue;
          }
        }
      }
    }
    return list;
  }

  @override
  List<Object?> get props => [items];
}

class TestBoardItem extends Equatable {
  final String id;
  final Position position;
  final int value;

  const TestBoardItem(this.id, this.position, this.value);

  @override
  List<Object?> get props => [id, position, value];
}