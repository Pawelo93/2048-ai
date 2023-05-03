import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/board_transformer_output.dart';
import 'package:game_2048/board/multi_tile.dart';
import 'package:game_2048/board/positioned_tile.dart';
import 'package:game_2048/board/tile.dart';
import 'package:game_2048/board_mover.dart';
import 'package:game_2048/game_controller.dart';
import 'package:game_2048/model/position.dart';
import 'package:game_2048/two_dimens_array.dart';

enum MovingActor {
  player,
  system,
}

enum MoveDirection {
  up,
  down,
  right,
  left,
}

abstract class GameState extends Equatable {}

class InitialGameState extends GameState {
  @override
  List<Object?> get props => [];
}

class PlayingGameState extends GameState {
  final Board board;
  final BoardTransformerOutput? boardTransformerOutput;
  final MovingActor movingActor;

  PlayingGameState({
    required this.board,
    required this.movingActor,
    this.boardTransformerOutput,
  });

  @override
  List<Object?> get props => [board, movingActor];
}

class GameBloc extends Cubit<GameState> {
  final GameController gameController = GameController();
  final BoardMover _boardMover = BoardMover();

  GameBloc() : super(InitialGameState());

  void startGame() {
    // final initialBoard = Board.fromPositionalTiles([
    //   PositionedTile('id1', Position(1, 1), 2),
    //   PositionedTile('id2', Position(3, 1), 2),
    //   PositionedTile('id3', Position(2, 3), 4),
    //   PositionedTile('id4', Position(1, 0), 2),
    // ]);
    final TwoDimensArray twoDimensArrayMultiTile = TwoDimensArray({});
    twoDimensArrayMultiTile.put(1, 1, const MultiTile([Tile('id1', 2)]));
    twoDimensArrayMultiTile.put(3, 1, const MultiTile([Tile('id2', 2)]));
    twoDimensArrayMultiTile.put(2, 3, const MultiTile([Tile('id3', 4)]));
    twoDimensArrayMultiTile.put(1, 0, const MultiTile([Tile('id4', 2)]));
    final initialBoard = Board(twoDimensArrayMultiTile);

    emit(PlayingGameState(
      board: initialBoard,
      movingActor: MovingActor.player,
    ));
  }

  void move(MoveDirection moveDirection) {
    final currentState = state;
    if (currentState is PlayingGameState) {
      if (currentState.movingActor == MovingActor.player) {
        final Board output;

        switch(moveDirection) {
          case MoveDirection.up:
            output = _boardMover.moveTop(currentState.board);
            break;
          case MoveDirection.down:
            output = _boardMover.moveDown(currentState.board);
            break;
          case MoveDirection.right:
            output = _boardMover.moveRight(currentState.board);
            break;
          case MoveDirection.left:
            output = _boardMover.moveLeft(currentState.board);
            break;
        }
        print('EMIT NEW BOARD $output');

        emit(PlayingGameState(
          board: output,
          movingActor: MovingActor.system,
          // boardTransformerOutput: output,
        ));
      }
    }
  }

  void systemMove() {
    final currentState = state;
    if (currentState is PlayingGameState) {
      print('SYSTEM MOVES');
      emit(PlayingGameState(
        board: currentState.board,
        movingActor: MovingActor.player,
      ));
    }
  }
}
