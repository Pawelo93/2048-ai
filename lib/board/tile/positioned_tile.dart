import 'package:equatable/equatable.dart';
import 'package:game_2048/board/util/position.dart';

class PositionedTile extends Equatable {
  final String id;
  final Position position;
  final int value;

  const PositionedTile(this.id, this.position, this.value);

  @override
  List<Object?> get props => [id, position, value];
}