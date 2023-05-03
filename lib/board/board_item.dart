import 'package:equatable/equatable.dart';

class BoardItem extends Equatable {
  final String id;
  final int value;

  const BoardItem(this.id, this.value);

  @override
  List<Object?> get props => [id, value];
}

