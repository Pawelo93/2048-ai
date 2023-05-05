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
    final sortedKeys = List.of(keys)..sort((a, b) => a.x.compareTo(b.x));
    return sortedKeys.map((e) => items[e]).where((element) => element != null).map((e) => e as MultiTile).toList();
  }

  @override
  List<Object?> get props => [items];
}
