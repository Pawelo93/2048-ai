import 'package:flutter/material.dart';
import 'package:game_2048/animating_board.dart';
import 'package:game_2048/board.dart';
import 'package:game_2048/board_rotator.dart';
import 'package:game_2048/board_transformer.dart';
import 'package:game_2048/board_view.dart';
import 'package:game_2048/model/position.dart';

class AnimatedBoardView extends StatefulWidget {
  const AnimatedBoardView({Key? key, required this.animatingBoard})
      : super(key: key);

  final AnimatingBoard animatingBoard;

  @override
  State<AnimatedBoardView> createState() => _AnimatedBoardViewState();
}

class _AnimatedBoardViewState extends State<AnimatedBoardView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        animate();
      },
      child: BoardView(
        board: widget.animatingBoard.toBoard(),
      ),
    );
  }

  void animate() {
    final board = widget.animatingBoard.toBoard();
    // final BoardRotator rotator = BoardRotator();
    // final rotatedBoard = rotator.rotate(board);
    final transformResult =
        BoardTransformer().transform(board);
    //
    // final backBoard = rotator.rotate(transformResult.newBoard);
    // final backBoard2 = rotator.rotate(backBoard);
    // final backBoard3 = rotator.rotate(backBoard2);


    // if (transformResult.newBoard == transformResult.oldBoard) {
    //   return;
    // }
    final oldTransforms = transformResult.transforms;
    final allTransforms = oldTransforms.map((e) => [BoardItem(e.from, e.value), BoardItem(e.to, e.value)]).toList();

    // final transFromBoard = Board([BoardItem(oldTransforms, value)])
    // final newTransforms =
    final newItems = transformResult.transforms.map((transform) {
      return AnimatingBoardItem(
        transform.from,
        transform.from,
        transform.to,
        transform.value,
      );
    }).toList();

    widget.animatingBoard.update(newItems);

    Tween<double> tween = Tween(begin: 0.0, end: 1.0);
    tween.animate(_curvedAnimation)
      ..addListener(() {
        setState(() {
          final dt = tween.evaluate(_curvedAnimation);
          widget.animatingBoard.animate(dt);
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
          setState(() {
            widget.animatingBoard.endAnimation(transformResult.newBoard);
          });
        }
      });

    _controller.forward();
  }
}
