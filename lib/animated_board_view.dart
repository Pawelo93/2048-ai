import 'package:flutter/material.dart';
import 'package:game_2048/board/positioned_tile.dart';
import 'package:game_2048/board_view.dart';

class AnimatedBoardView extends StatelessWidget {
  const AnimatedBoardView({Key? key, required this.positionedTiles,}) : super(key: key);

  final List<PositionedTile> positionedTiles;

  @override
  Widget build(BuildContext context) {
    return BoardView(
      positionedTiles: positionedTiles,
    );
  }
}
