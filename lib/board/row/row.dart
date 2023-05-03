import 'package:equatable/equatable.dart';
import 'package:game_2048/board/multi_tile.dart';

class Row extends Equatable {
  final Map<int, MultiTile?> tiles;

  const Row(this.tiles);

  @override
  List<Object?> get props => [tiles];
}