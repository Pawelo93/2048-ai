import 'package:equatable/equatable.dart';
import 'package:game_2048/board/multi_tile.dart';
import 'package:game_2048/model/position.dart';

class TwoDimensArray extends Equatable {
  final Map<Position, MultiTile> items;

  const TwoDimensArray(this.items);

  void put(int x, int y, MultiTile item) {
    items[Position.int(x, y)] = item;
  }

  MultiTile? get(int x, int y) {
    return items[Position.int(x, y)];
  }

  List<MultiTile> getRow(int y) {
    final keys = items.keys.where((element) => element.y == y).toList();
    return items.entries.where((element) => keys.contains(element.key)).map((e) => e.value).toList();
  }

  @override
  List<Object?> get props => [items];
}
