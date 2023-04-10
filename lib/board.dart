import 'package:game_2048/board_view.dart';

class Board {
  List<BoardItem> items = [];

  Board(this.items);

}

class BoardItem {
  final Position position;

  BoardItem(this.position);
}