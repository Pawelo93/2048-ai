// import 'package:flutter/material.dart';
// import 'package:game_2048/animating_board.dart';
// import 'package:game_2048/board/board_test.dart';
// import 'package:game_2048/old_board_transformer.dart';
// import 'package:game_2048/board_view.dart';
//
// class AnimatedBoardView extends StatefulWidget {
//   const AnimatedBoardView({Key? key, required this.board, this.boardTransformerOutput}) : super(key: key);
//
//   final Board board;
//   // final Board? newBoard;
//   final BoardTransformerOutput? boardTransformerOutput;
//
//   @override
//   State<AnimatedBoardView> createState() => _AnimatedBoardViewState();
// }
//
// class _AnimatedBoardViewState extends State<AnimatedBoardView>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late CurvedAnimation _curvedAnimation;
//
//   final AnimatingBoard _animatingBoard = AnimatingBoard();
//
//   @override
//   void initState() {
//     _animatingBoard.update(widget.board.items
//         .map((e) =>
//         AnimatingBoardItem(e.position, e.position, e.position, e.value))
//         .toList());
//     _controller = AnimationController(
//         duration: const Duration(milliseconds: 1250), vsync: this);
//     _curvedAnimation =
//         CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_animatingBoard.toBoardItems() != widget.board.items) {
//       _animatingBoard.isCompleted = false;
//     }
//
//     if (widget.boardTransformerOutput != null && !_controller.isAnimating) {
//       if (!_animatingBoard.isCompleted) {
//         print('HERE ANIMATE ##');
//         animate(widget.boardTransformerOutput!);
//       }
//     }
//
//     return BoardView(
//       items: _animatingBoard.toBoardItems(),
//     );
//   }
//
//   void animate(BoardTransformerOutput transformResult) {
//     // final transformResult = moveRight(widget.board);
//     final transforms = transformResult.transforms;
//     final newBoard = transformResult.newBoard;
//
//     final newItems = transforms.map((transform) {
//       return AnimatingBoardItem(
//         transform.from,
//         transform.from,
//         transform.to,
//         transform.value,
//       );
//     }).toList();
//
//     // print('ANIMATE @@@');
//
//     _animatingBoard.update(newItems);
//
//     Tween<double> tween = Tween(begin: 0.0, end: 1.0);
//     tween.animate(_curvedAnimation)
//       ..addListener(() {
//         setState(() {
//           final dt = tween.evaluate(_curvedAnimation);
//           _animatingBoard.animate(dt);
//         });
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _controller.reset();
//           print('END ANIMATION');
//           setState(() {
//             _animatingBoard.endAnimation(newBoard);
//           });
//         }
//       });
//
//     _controller.forward();
//   }
//
// }
