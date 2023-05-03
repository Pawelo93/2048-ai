import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/board_manager.dart';
import 'package:game_2048/board/board_transformer_output.dart';
import 'package:game_2048/board/multi_tile.dart';
import 'package:game_2048/board/tile.dart';
import 'package:game_2048/board_mover.dart';
import 'package:game_2048/game_controller.dart';
import 'package:game_2048/two_dimens_array.dart';
import 'package:uuid/uuid.dart';

enum MovingActor {
  player,
  system,
  waitingForAnimation,
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
  final BoardManager _boardManager = BoardManager();

  GameBloc() : super(InitialGameState());

  void startGame() {
    const uuid = Uuid();
    final TwoDimensArray twoDimensArrayMultiTile = TwoDimensArray(HashMap());
    twoDimensArrayMultiTile.put(1, 1, MultiTile.single(Tile('1', 2)));
    twoDimensArrayMultiTile.put(2, 3, MultiTile.single(Tile('3', 8)));
    twoDimensArrayMultiTile.put(3, 1, MultiTile.single(Tile('2', 2)));
    twoDimensArrayMultiTile.put(1, 0, MultiTile.single(Tile('4', 2)));
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

        switch (moveDirection) {
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

        emit(PlayingGameState(
          board: output,
          movingActor: MovingActor.waitingForAnimation,
          // boardTransformerOutput: output,
        ));

        Future.delayed(Duration(milliseconds: 1500)).then((value) {
          final currentState = state;
          if (currentState is PlayingGameState) {
            final mergedBoard = _boardManager.merge(currentState.board);

            emit(PlayingGameState(
              board: mergedBoard,
              movingActor: MovingActor.system,
            ));
          }
        });
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
