import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/animated_board_view.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/game_bloc.dart';

class GameWidget extends StatelessWidget {
  const GameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameBloc>(
      create: (_) => GameBloc()..startGame(),
      child: const GameView(),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          context.read<GameBloc>().move(MoveDirection.left);
        } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          context.read<GameBloc>().move(MoveDirection.right);
        } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          context.read<GameBloc>().move(MoveDirection.up);
        } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          context.read<GameBloc>().move(MoveDirection.down);
        }
      },
      child: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          if (state is PlayingGameState) {
            if (state.movingActor == MovingActor.system) {
              Future.delayed(Duration(milliseconds: 1500)).then((value) => context.read<GameBloc>().systemMove());
              // context.read<GameBloc>().systemMove();
            }
          }
        },
        builder: (context, state) {
          if (state is PlayingGameState) {
            return GamePlayingStateView(
              board: state.board,
            );
          }

          return Text('Unknown state ${state}');
        },
      ),
    );
  }
}

class GamePlayingStateView extends StatelessWidget {
  const GamePlayingStateView({
    Key? key,
    required this.board,
  }) : super(key: key);

  final Board board;
  // final BoardTransformerOutput? boardTransformerOutput;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBoardView(
          positionedTiles: board.toPositionedTiles(),
          // boardTransformerOutput: boardTransformerOutput,
        ),
      ],
    );
  }
}
