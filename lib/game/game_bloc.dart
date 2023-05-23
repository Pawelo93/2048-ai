import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/board_manager.dart';
import 'package:game_2048/board/tile/multi_tile.dart';
import 'package:game_2048/board/tile/tile.dart';
import 'package:game_2048/board/board_mover.dart';
import 'package:game_2048/board/util/two_dimens_array.dart';
import 'package:game_2048/game_mode.dart';
import 'package:game_2048/main.dart';

const int animationSpeed = gameMode == GameMode.ai ? 5 : 50;

enum WaitingGameType {
  beforeStart,
  gameOver,
}

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

abstract class HasBoardState extends GameState {
  final Board board;

  HasBoardState({required this.board});
}

class InitialGameState extends GameState {
  @override
  List<Object?> get props => [];
}

class WaitingGameState extends HasBoardState {
  final WaitingGameType waitingGameType;

  WaitingGameState({
    required super.board,
    required this.waitingGameType,
  });

  @override
  List<Object?> get props => [board, waitingGameType];

}

class PlayingGameState extends HasBoardState {
  final MovingActor movingActor;
  final int addToScore;

  PlayingGameState({
    required super.board,
    required this.movingActor,
    this.addToScore = 0,
  });

  @override
  List<Object?> get props => [board, movingActor, addToScore];
}

class GameBloc extends Cubit<GameState> {
  final BoardMover _boardMover = BoardMover();
  final BoardManager _boardManager = BoardManager();

  GameBloc() : super(InitialGameState());

  void startGame() {
    final TwoDimensArray twoDimensArrayMultiTile = TwoDimensArray(HashMap());
    twoDimensArrayMultiTile.put(1, 2, MultiTile.single(const Tile('1', 2)));
    twoDimensArrayMultiTile.put(2, 3, MultiTile.single(const Tile('3', 8)));
    twoDimensArrayMultiTile.put(1, 0, MultiTile.single(const Tile('2', 4)));
    twoDimensArrayMultiTile.put(1, 0, MultiTile.single(const Tile('4', 2)));
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
        final isMoveValid =
            _boardMover.isMoveValid(currentState.board, moveDirection);

        if (!isMoveValid) {
          return;
        }

        final Board output =
            _boardMover.move(currentState.board, moveDirection);


        emit(PlayingGameState(
          board: output,
          movingActor: MovingActor.waitingForAnimation,
        ));
      }
    }
  }

  void animationEnd() {
    final currentState = state;
    if (currentState is PlayingGameState &&
        currentState.movingActor == MovingActor.waitingForAnimation) {
      final mergeResult = _boardManager.merge(currentState.board);

      emit(PlayingGameState(
        board: mergeResult.board,
        movingActor: MovingActor.system,
        addToScore: mergeResult.points,
      ));
    }
  }

  void systemMove() {
    final currentState = state;
    if (currentState is PlayingGameState) {
      final boardWithNewTile = _boardManager.addRandomTile(currentState.board);

      final isGameOver = checkIfGameOver(boardWithNewTile);
      print('IS GAME OVER ??? $isGameOver   ---- ${boardWithNewTile.array.items.length}');
      if (isGameOver) {
        emit(WaitingGameState(
          board: boardWithNewTile,
          waitingGameType: WaitingGameType.gameOver,
        ));
      } else {
        emit(PlayingGameState(
          board: boardWithNewTile,
          movingActor: MovingActor.player,
        ));
      }
    }
  }

  bool checkIfGameOver(Board board) {
    return board == _boardMover.move(board, MoveDirection.left) &&
        board == _boardMover.move(board, MoveDirection.right) &&
        board == _boardMover.move(board, MoveDirection.up) &&
        board == _boardMover.move(board, MoveDirection.down);
  }

  void stop() {
    final currentState = state;
    if (currentState is PlayingGameState) {
      print('STOP');
      emit(WaitingGameState(board: currentState.board, waitingGameType: WaitingGameType.beforeStart));
    }
  }
}
