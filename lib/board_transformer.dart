import 'package:equatable/equatable.dart';
import 'package:game_2048/board.dart';
import 'package:game_2048/model/position.dart';

class BoardTransformer {
  BoardTransformerOutput transform(Board oldBoard) {
    final transforms = <Transform>[];

    final newItems = <BoardItem>[];
    final rows = oldBoard.asList();
    for (double y = 0; y < rows.length; y++) {
      final row = rows[y.toInt()];

      final rowOnlyNotNull = _mapToRowItems(row);
      final emptyRow = rowOnlyNotNull.isEmpty;
      if (emptyRow) {
        continue;
      }
      final singleValue = rowOnlyNotNull.length == 1;
      if (singleValue) {
        final int value = rowOnlyNotNull[0].value;
        newItems.add(BoardItem(Position(0, y.toDouble()), value));
        final index = row.indexWhere((element) => element > 0);
        if (index != 0) {
          transforms.add(
            Transform(
              Position(index.toDouble(), y),
              Position(0, y),
              value,
            ),
          );
        }
        continue;
      }

      final twoSameValues =
          rowOnlyNotNull.length == 2 && rowOnlyNotNull[0] == rowOnlyNotNull[1];
      if (twoSameValues) {
        final value = rowOnlyNotNull[0].value;
        newItems.add(BoardItem(Position(0, y.toDouble()), value * value));

        transforms.add(Transform(Position(rowOnlyNotNull[0].index.toDouble(), y), Position(0, y), value));
        transforms.add(Transform(Position(rowOnlyNotNull[1].index.toDouble(), y), Position(0, y), value));
        continue;
      }

      final twoDiffValues =
          rowOnlyNotNull.length == 2 && rowOnlyNotNull[0] != rowOnlyNotNull[1];
      if (twoDiffValues) {
        final leftValue = rowOnlyNotNull[0].value;
        final rightValue = rowOnlyNotNull[1].value;
        newItems.add(BoardItem(Position(0, y.toDouble()), leftValue));
        newItems.add(BoardItem(Position(1, y.toDouble()), rightValue));

        transforms.add(Transform(Position(rowOnlyNotNull[0].index.toDouble(), y), Position(0, y), leftValue));
        transforms.add(Transform(Position(rowOnlyNotNull[1].index.toDouble(), y), Position(1, y), rightValue));
        continue;
      }

      bool merged = false;
      if (rowOnlyNotNull.length >= 2 &&
          rowOnlyNotNull[0] == rowOnlyNotNull[1]) {
        newItems.add(BoardItem(
            Position(0, y.toDouble()), rowOnlyNotNull[0].value * rowOnlyNotNull[0].value));
        merged = true;
      }

      if (merged) {
        if (rowOnlyNotNull.length == 3) {
          newItems.add(BoardItem(Position(1, y.toDouble()), rowOnlyNotNull[2].value));
        } else if (rowOnlyNotNull.length == 4) {
          if (rowOnlyNotNull[2] == rowOnlyNotNull[3]) {
            newItems.add(BoardItem(Position(1, y.toDouble()),
                rowOnlyNotNull[2].value * rowOnlyNotNull[2].value));
          } else {
            newItems
                .add(BoardItem(Position(1, y.toDouble()), rowOnlyNotNull[2].value));
            newItems
                .add(BoardItem(Position(2, y.toDouble()), rowOnlyNotNull[3].value));
          }
        }
      } else {
        bool merged2 = false;
        if (rowOnlyNotNull[1] == rowOnlyNotNull[2]) {
          newItems.add(BoardItem(Position(0, y.toDouble()), rowOnlyNotNull[0].value));
          newItems.add(BoardItem(Position(1, y.toDouble()),
              rowOnlyNotNull[1].value * rowOnlyNotNull[2].value));
          merged2 = true;
        }

        if (rowOnlyNotNull[1] != rowOnlyNotNull[2]) {
          newItems.add(BoardItem(Position(0, y.toDouble()), rowOnlyNotNull[0].value));
          newItems.add(BoardItem(Position(1, y.toDouble()), rowOnlyNotNull[1].value));
        }

        if (rowOnlyNotNull.length == 3) {
          newItems.add(BoardItem(Position(2, y.toDouble()), rowOnlyNotNull[2].value));
        }

        if (rowOnlyNotNull.length == 4 &&
            rowOnlyNotNull[2] == rowOnlyNotNull[3] &&
            !merged2) {
          newItems.add(BoardItem(Position(2, y.toDouble()),
              rowOnlyNotNull[2].value * rowOnlyNotNull[3].value));
        } else if (rowOnlyNotNull.length == 4 &&
            rowOnlyNotNull[2] == rowOnlyNotNull[3]) {
          newItems.add(BoardItem(Position(2, y.toDouble()), rowOnlyNotNull[2].value));
        }
      }
    }

    final newBoard = Board(newItems);

    return BoardTransformerOutput(newBoard, oldBoard, transforms);
  }

  List<RowItem> _mapToRowItems(List<int> list) {
    return List<int>.from(list)
        .asMap()
        .entries
        .map((entry) => RowItem(entry.key, entry.value))
        .where((element) => element.value > 0)
        .toList();
  }
}

class RowItem extends Equatable {
  final int index;
  final int value;

  const RowItem(this.index, this.value);

  @override
  List<Object?> get props => [value];
}

class BoardTransformerOutput extends Equatable {
  final Board newBoard;
  final Board oldBoard;
  final List<Transform> transforms;
  final MergeAnim? mergeAnim;

  const BoardTransformerOutput(this.newBoard, this.oldBoard, this.transforms, [this.mergeAnim]);

  @override
  List<Object?> get props => [newBoard, oldBoard, transforms, mergeAnim];
}

class Transform extends Equatable {
  final Position from;
  final Position to;
  final int value;

  const Transform(this.from, this.to, this.value);

  @override
  List<Object?> get props => [from, to, value];

  // Board asBoard() {
  //   Board board = Board([BoardItem(from, value), BoardItem(to, value), ]);
  //   // for (var y; y < 4; y++) {
  //   //   for (var x; x < 4; x++) {
  //   //
  //   //   }
  //   // }
  // }
}

class MergeAnim extends Equatable {
  final int fromValue;
  final int toValue;

  const MergeAnim(this.fromValue, this.toValue);

  @override
  List<Object?> get props => [fromValue, toValue];
}
