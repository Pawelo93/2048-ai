import 'package:flutter/material.dart';
import 'package:game_2048/board/positioned_tile.dart';
import 'package:game_2048/model/position.dart';

const Color color2 = Color(0xFFeee4da);
const Color color4 = Color(0xFFeee1ca);
const Color color8 = Color(0xFFf3b279);
const Color color16 = Color(0xFFf69564);
const Color color32 = Color(0xFFf77c5f);
const Color color64 = Color(0xFFf75f3c);

class BoardView extends StatelessWidget {
  const BoardView({
    Key? key,
    required this.positionedTiles,
  }) : super(key: key);

  final List<PositionedTile> positionedTiles;

  @override
  Widget build(BuildContext context) {
    final backgroundItems = <Position>[];
    for (var i = 0; i < 4; i++) {
      for (var j = 0; j < 4; j++) {
        backgroundItems.add(Position(j.toDouble(), i.toDouble()));
      }
    }

    final boardWidth = MediaQuery.of(context).size.width / 2;
    final boardHeight = boardWidth;

    const gap = 12.0;
    final width = (boardWidth - 5 * gap) / 4;
    final height = width;

    return Container(
      width: boardWidth,
      height: boardHeight,
      padding: const EdgeInsets.all(gap),
      decoration: BoxDecoration(
        color: const Color(0xFFbcac9f),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          ...backgroundItems.map((item) {
            return Positioned(
              left: item.x * (width + gap),
              top: item.y * (height + gap),
              width: width,
              height: height,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFccc1b4),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
          ...positionedTiles.where((tile) => tile.value > 0).map((item) {
            return AnimatedPositioned(
              key: ValueKey(item.id),
              duration: const Duration(milliseconds: 150),
              left: item.position.x * (width + gap),
              top: item.position.y * (height + gap),
              child: TileItem(
                tile: item,
                width: width,
                height: height,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class TileItem extends StatefulWidget {
  const TileItem({
    Key? key,
    required this.tile,
    required this.width,
    required this.height,
  }) : super(key: key);

  final PositionedTile tile;
  final double width;
  final double height;

  @override
  State<TileItem> createState() => _TileItemState();
}

class _TileItemState extends State<TileItem>
    with SingleTickerProviderStateMixin {
  final Tween<double> _tween = Tween(begin: 0.6, end: 1.0);
  late AnimationController _animationController;
  late CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _tween.animate(_curvedAnimation),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: getItemColor(widget.tile.value),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            widget.tile.value.toString(),
            style: const TextStyle(
              color: Color(0xFF776e65),
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Color getItemColor(int value) {
    switch (value) {
      case 2:
        return color2;
      case 4:
        return color4;
      case 8:
        return color8;
      case 16:
        return color16;
      case 32:
        return color32;
      default:
        return const Color(0xFFccc1b4);
    }
  }
}
