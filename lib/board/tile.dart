import 'package:equatable/equatable.dart';

class Tile extends Equatable {
  final String id;
  final int value;

  const Tile(this.id, this.value);

  @override
  List<Object?> get props => [id, value];
}