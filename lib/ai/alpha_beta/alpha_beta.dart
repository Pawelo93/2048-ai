import 'package:equatable/equatable.dart';
import 'package:game_2048/ai/genetic/genetic_manager.dart';
import 'package:game_2048/ai/maximizing_player.dart';
import 'package:game_2048/ai/score_calculator.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/board_mover.dart';
import 'package:game_2048/board/board_tile_merger.dart';
import 'package:game_2048/board/tile/tile_adder.dart';
import 'package:game_2048/board/util/position.dart';
import 'package:game_2048/game/game_bloc.dart';

class AlphaBeta {
  final TileAdder _tileAdder = TileAdder();
  final BoardMover _boardMover = BoardMover();
  final BoardTileMerger _boardTileMerger = BoardTileMerger();
  final ScoreCalculator _scoreCalculator = ScoreCalculator();

  void setupWeights(ScoreWeights weights) {
    _scoreCalculator.setupWeights(weights);
  }

  Future<AlphaBetaResult> alphaBeta(
    Board board,
    int depth,
    MaximizingPlayer maximizingPlayer,
    int points,
    double alpha,
    double beta,
  ) async {
    MoveDirection? bestDirection;
    double bestScore = 0;

    if (depth == 0) {
      final score = _scoreCalculator.calculate(board, points);
      return AlphaBetaResult(score, bestDirection);
    }

    if (maximizingPlayer == MaximizingPlayer.player) {
      final moveResult = await checkPlayerMoves(board, depth, alpha, beta);
      bestDirection = moveResult.direction;
      bestScore = moveResult.score;
    } else {
      bestScore = await checkSystemMove(board, depth, points, alpha, beta);
    }

    return AlphaBetaResult(bestScore, bestDirection);
  }

  Future<PlayerMoveResult> checkPlayerMoves(
    Board board,
    int depth,
    double alpha,
    double beta,
  ) async {
    MoveDirection? bestDirection;

    if (isGameTerminated(board)) {
      alpha = 0;
      return PlayerMoveResult(alpha, bestDirection);
    }

    for (final direction in MoveDirection.values) {
      if (!_boardMover.isMoveValid(board, direction)) {
        continue;
      }

      final movedBoard = _boardMover.move(board, direction);
      final mergedBoard = _boardTileMerger.merge(movedBoard);
      AlphaBetaResult nextResult = await alphaBeta(
        mergedBoard.board,
        depth - 1,
        MaximizingPlayer.system,
        mergedBoard.points,
        alpha,
        beta,
      );
      double nextScore = nextResult.score;

      if (nextScore > alpha) {
        alpha = nextScore;
        bestDirection = direction;
      }
      if (beta <= alpha) {
        break;
      }
    }

    return PlayerMoveResult(alpha, bestDirection);
  }

  Future<double> checkSystemMove(
    Board board,
    int depth,
    int points,
    double alpha,
    double beta,
  ) async {
    // double bestScore = startScore;

    List<Position> emptyTiles = _getEmptyPositions(board);
    if (emptyTiles.isEmpty) {
      return beta;
    }

    List<int> possibleValues = [2, 4];

    for (final position in emptyTiles) {
      for (final possibleValue in possibleValues) {
        final newBoard = _tileAdder.addTile(
            board, position.intX, position.intY, possibleValue);
        AlphaBetaResult nextResult = await alphaBeta(
            newBoard, depth - 1, MaximizingPlayer.player, points, alpha, beta);
        double nextScore = nextResult.score;

        if (nextScore < beta) {
          beta = nextScore;
        }

        if (beta <= alpha) {
          return beta;
        }
      }
    }

    return beta;
  }

  bool isGameTerminated(Board board) {
    for (MoveDirection direction in MoveDirection.values) {
      final isValid = _boardMover.isMoveValid(board, direction);
      if (isValid) {
        return false;
      }
    }
    return true;
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

class AlphaBetaResult extends Equatable {
  final double score;
  final MoveDirection? direction;

  const AlphaBetaResult(this.score, this.direction);

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
