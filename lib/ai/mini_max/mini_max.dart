import 'dart:isolate';

import 'package:dart_numerics/dart_numerics.dart' as numerics;
import 'package:equatable/equatable.dart';
import 'package:game_2048/ai/score_calculator.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/board_mover.dart';
import 'package:game_2048/board/board_tile_merger.dart';
import 'package:game_2048/board/tile/tile_adder.dart';
import 'package:game_2048/board/util/position.dart';
import 'package:game_2048/game/game_bloc.dart';

enum MaximizingPlayer {
  system,
  player,
}

class MiniMax {
  final TileAdder _tileAdder = TileAdder();
  final BoardMover _boardMover = BoardMover();
  final BoardTileMerger _boardTileMerger = BoardTileMerger();
  final ScoreCalculator _scoreCalculator = ScoreCalculator();

  Future<MiniMaxResult> minimax(
    Board board,
    int depth,
    MaximizingPlayer maximizingPlayer,
    int points,
  ) async {
    MoveDirection bestDirection = MoveDirection.left;

    if (depth == 0) {
      final score = _scoreCalculator.calculate(board, points);
      return MiniMaxResult(score, bestDirection);
    }

    if (maximizingPlayer == MaximizingPlayer.player) {
      final moveResult = await checkPlayerMoves(board, depth, -9999999);
      bestDirection = moveResult.direction;
      return MiniMaxResult(moveResult.score, bestDirection);
    } else {
      int score = await checkSystemMove(board, depth, numerics.int64MaxValue, points);
      return MiniMaxResult(score, bestDirection);
    }
  }

  Future<PlayerMoveResult> checkPlayerMoves(Board board, int depth, int startScore) async {
    MoveDirection bestDirection = MoveDirection.left;
    int bestScore = startScore;

    for (final direction in MoveDirection.values) {
      if (!isMoveLegal(board, direction)) {
        continue;
      }

      final movedBoard = _boardMover.move(board, direction);
      final mergedBoard = _boardTileMerger.merge(movedBoard);
      MiniMaxResult nextResult = await minimax(mergedBoard.board, depth - 1, MaximizingPlayer.system, mergedBoard.points);
      int nextScore = nextResult.score;

      if (nextScore > bestScore) {
        bestScore = nextScore;
        bestDirection = direction;
      }
    }

    return PlayerMoveResult(bestScore, bestDirection);
  }

  Future<int> checkSystemMove(Board board, int depth, int startScore, int points) async {
    int bestScore = startScore;

    List<Position> emptyTiles = _getEmptyPositions(board);
    if (emptyTiles.isEmpty) {
      return bestScore;
    }

    List<int> possibleValues = [2, 4];

    for (final position in emptyTiles) {
      for (final possibleValue in possibleValues) {
        final newBoard = _tileAdder.addTile(board, position.intX, position.intY, possibleValue);
        MiniMaxResult nextResult = await minimax(newBoard, depth - 1, MaximizingPlayer.player, points);
        int nextScore = nextResult.score;

        if (nextScore < bestScore) {
          bestScore = nextScore;
        }
      }
    }

    return bestScore;
  }

  bool isMoveLegal(Board board, MoveDirection moveDirection) {
    final newBoard = _boardMover.move(board, moveDirection);
    return newBoard != board;
  }

  List<Position> _getEmptyPositions(Board board) {
    List<Position> positions = [];
    for (var y = 0; y < 4; y++) {
      for (var x = 0; x < 4; x++) {
        if (board.array.get(x, y) == null) {
          positions.add(Position.int(x, y));
        }
      }
    }
    return positions;
  }
}

class MiniMaxResult extends Equatable {
  final int score;
  final MoveDirection direction;

  const MiniMaxResult(this.score, this.direction);

  @override
  List<Object?> get props => [score, direction];
}

class PlayerMoveResult extends Equatable {
  final int score;
  final MoveDirection direction;

  const PlayerMoveResult(this.score, this.direction);

  @override
  List<Object?> get props => [score, direction];
}
