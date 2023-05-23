import 'dart:isolate';

import 'package:dart_numerics/dart_numerics.dart' as numerics;
import 'package:equatable/equatable.dart';
import 'package:game_2048/ai/genetic/genetic_manager.dart';
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

  void setupWeights(ScoreWeights weights) {
    _scoreCalculator.setupWeights(weights);
  }

  Future<MiniMaxResult> minimax(
    Board board,
    int depth,
    MaximizingPlayer maximizingPlayer,
    int points,
  ) async {
    MoveDirection? bestDirection = null;

    if (depth == 0) {
      final score = _scoreCalculator.calculate(board, points);
      return MiniMaxResult(score, bestDirection);
    }

    if (maximizingPlayer == MaximizingPlayer.player) {
      final moveResult = await checkPlayerMoves(board, depth, -double.infinity);
      bestDirection = moveResult.direction;
      return MiniMaxResult(moveResult.score, bestDirection);
    } else {
      double score = await checkSystemMove(board, depth, double.infinity, points);
      return MiniMaxResult(score, bestDirection);
    }
  }

  Future<PlayerMoveResult> checkPlayerMoves(Board board, int depth, double startScore) async {
    MoveDirection? bestDirection = null;
    double bestScore = startScore;

    for (final direction in MoveDirection.values) {
      if (!isMoveLegal(board, direction)) {
        print('DIR $direction   depth $depth');
        continue;
      }

      final movedBoard = _boardMover.move(board, direction);
      final mergedBoard = _boardTileMerger.merge(movedBoard);
      MiniMaxResult nextResult = await minimax(mergedBoard.board, depth - 1, MaximizingPlayer.system, mergedBoard.points);
      double nextScore = nextResult.score;

      if (nextScore > bestScore) {
        bestScore = nextScore;
        bestDirection = direction;
        print('BEST DIR  ${direction}  BUT IS IT LEGAL??? ${isMoveLegal(board, direction)}  depth $depth');
      }
      print('NOT BEST DIR ${direction}   BUT IS IT LEGAL??? ${isMoveLegal(board, direction)} depth $depth');
    }

    return PlayerMoveResult(bestScore, bestDirection);
  }

  Future<double> checkSystemMove(Board board, int depth, double startScore, int points) async {
    double bestScore = startScore;

    List<Position> emptyTiles = _getEmptyPositions(board);
    if (emptyTiles.isEmpty) {
      return bestScore;
    }

    List<int> possibleValues = [2, 4];

    for (final position in emptyTiles) {
      for (final possibleValue in possibleValues) {
        final newBoard = _tileAdder.addTile(board, position.intX, position.intY, possibleValue);
        MiniMaxResult nextResult = await minimax(newBoard, depth - 1, MaximizingPlayer.player, points);
        double nextScore = nextResult.score;

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
  final double score;
  final MoveDirection? direction;

  const MiniMaxResult(this.score, this.direction);

  @override
  List<Object?> get props => [score, direction];
}

class PlayerMoveResult extends Equatable {
  final double score;
  final MoveDirection? direction;

  const PlayerMoveResult(this.score, this.direction);

  @override
  List<Object?> get props => [score, direction];
}
