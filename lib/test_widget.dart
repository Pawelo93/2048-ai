import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:game_2048/board/test_board.dart';

class Tile extends Equatable {
  final String id;
  final int value;

  const Tile(this.id, this.value);

  @override
  List<Object?> get props => [id, value];
}

class TestWidget extends StatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  TestBoard board = TestBoard.fromList([
    [[null], [Tile('id-1', 2)], [Tile('id-2', 2)]],
    [[null], [null], [null]],
    [[null], [null], [null]],
  ]);
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BoardTest(board: board),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (counter == 1) {
                board = TestBoard.fromList([
                  [[Tile('id-1', 2), Tile('id-2', 2)], [], []],
                  [[null], [null], [null]],
                  [[null], [null], [null]],
                ]);
              } else if (counter == 2) {
                board = TestBoard.fromList([
                  [[null], [null], [null]],
                  [[null], [null], [null]],
                  [[null], [null], [null]],
                ]);
              }
              counter++;
            });
          },
          child: Text('tap'),
        ),
      ],
    );
  }
}

class BoardTest extends StatelessWidget {
  const BoardTest({
    Key? key,
    required this.board,
  }) : super(key: key);

  final TestBoard board;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,
      child: Column(
        children: [
          Row(
            children: [
              ...board.items
                  .where((element) => element.value > 0)
                  .map((e) => Text(e.value.toString() + ', ')),
            ],
          ),
          SizedBox(height: 24),
          Expanded(
            child: Stack(
              children: [
                ...board.items.where((element) => element.value > 0).map(
                      (e) => Positioned(
                        key: ValueKey(e.id),
                        left: e.position.x * 50,
                        top: e.position.y * 50,
                        // duration: const Duration(milliseconds: 500),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: ColoredBox(
                            color: Colors.red,
                            child: Center(
                              child: Text(
                                e.value.toString(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class _TestWidgetState extends State<TestWidget> {
//   List<double> leftPosition = [50];
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         BoardTest(leftPosition: leftPosition),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               leftPosition[0] = 200;
//               leftPosition.add(300);
//             });
//           },
//           child: Text('tap'),
//         ),
//       ],
//     );
//   }
// }
//
// class BoardTest extends StatelessWidget {
//   const BoardTest({
//     Key? key,
//     required this.leftPosition,
//   }) : super(key: key);
//
//   final List<double> leftPosition;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 400,
//       height: 400,
//       child: Stack(
//         children: [
//           ...leftPosition.map((e) => AnimatedPositioned(
//             left: e,
//             top: 50,
//             duration: const Duration(milliseconds: 500),
//             child: const SizedBox(
//               width: 50,
//               height: 50,
//               child: ColoredBox(
//                 color: Colors.red,
//               ),
//             ),
//           ),
//           ),
//         ],
//       ),
//     );
//   }
// }
