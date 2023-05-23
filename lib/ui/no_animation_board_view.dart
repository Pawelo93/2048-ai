import 'package:flutter/material.dart';
import 'package:game_2048/app_colors.dart';
import 'package:game_2048/board/tile/positioned_tile.dart';
import 'package:game_2048/board/util/position.dart';

class NoAnimationBoardWidget extends StatelessWidget {
  const NoAnimationBoardWidget({Key? key, required this.positionedTiles}) : super(key: key);

  final List<PositionedTile> positionedTiles;

  @override
  Widget build(BuildContext context) {
    final boardWidth = MediaQuery.of(context).size.width / 2;

    return NoAnimationBoardView(
      positionedTiles: positionedTiles,
      boardWidth: boardWidth,
    );
  }
}

class NoAnimationBoardView extends StatelessWidget {
  const NoAnimationBoardView({
    Key? key,
    required this.positionedTiles,
    required this.boardWidth,
  }) : super(key: key);

  final List<PositionedTile> positionedTiles;
  final double boardWidth;

  @override
  Widget build(BuildContext context) {
    final backgroundItems = <Position>[];
    for (var i = 0; i < 4; i++) {
      for (var j = 0; j < 4; j++) {
        backgroundItems.add(Position(j.toDouble(), i.toDouble()));
      }
    }

    final boardHeight = boardWidth;

    const gap = 8.0;
    final width = (boardWidth - 5 * gap) / 4;
    final height = width;

    return Container(
      width: boardWidth,
      height: boardHeight,
      padding: const EdgeInsets.all(gap),
      decoration: BoxDecoration(
        color: AppColors.background,
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
                  color: AppColors.lightBackground,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
          ...positionedTiles.where((tile) => tile.value > 0).map((item) {
            return Positioned(
              key: ValueKey(item.id),
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

class TileItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: getItemColor(tile.value),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          tile.value.toString(),
          style: TextStyle(
            color: AppColors.tileTextColor,
            fontSize: getSize(tile.value),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Color getItemColor(int value) {
    switch (value) {
      case 2:
        return AppColors.color2;
      case 4:
        return AppColors.color4;
      case 8:
        return AppColors.color8;
      case 16:
        return AppColors.color16;
      case 32:
        return AppColors.color32;
      case 64:
        return AppColors.color64;
      case 128:
        return AppColors.color128;
      case 256:
        return AppColors.color256;
      case 512:
        return AppColors.color512;
      case 1024:
        return AppColors.color1024;
      case 2048:
        return AppColors.color2048;
      default:
        return AppColors.color4096;
    }
  }

  double getSize(int value) {
    if (value < 100) {
      return 20;
    } else if (value < 1000) {
      return 14;
    } else if (value < 10000) {
      return 10;
    } else {
      return 7;
    }
  }
}