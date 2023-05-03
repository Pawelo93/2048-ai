import 'package:equatable/equatable.dart';
import 'package:game_2048/board/tile.dart';

class MultiTile extends Equatable {
  final List<Tile> tiles;

  const MultiTile(this.tiles);

  factory MultiTile.single(Tile tile) {
    return MultiTile([tile]);
  }




  bool get isNotEmpty => tiles.isNotEmpty;

  bool get isSingle => tiles.length <= 1;

  Tile? get firstOrNull => tiles.isNotEmpty ? tiles.first : null;

  @override
  List<Object?> get props => [tiles];
}