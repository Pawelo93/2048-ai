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
}
