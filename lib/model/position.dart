import 'package:equatable/equatable.dart';

class Position extends Equatable {
  final double x;
  final double y;

  int get intX => x.toInt();
  int get intY => x.toInt();

  const Position(this.x, this.y);

  factory Position.int(int x, int y) => Position(x.toDouble(), y.toDouble());

  @override
  List<Object?> get props => [x, y];
}