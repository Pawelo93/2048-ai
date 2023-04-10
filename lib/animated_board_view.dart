import 'package:flutter/material.dart';
import 'package:game_2048/animating_board.dart';
import 'package:game_2048/board_view.dart';

class AnimatedBoardView extends StatefulWidget {
  const AnimatedBoardView({Key? key, required this.animatingBoard}) : super(key: key);

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
        duration: const Duration(milliseconds: 1000), vsync: this);
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
    widget.animatingBoard.update(AnimatingBoardItem(Position(2, 1), Position(2, 1), Position(2, 3), 2));

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
          widget.animatingBoard.endAnimation();
          _controller.reset();
        }
      });

    _controller.forward();
  }
}
