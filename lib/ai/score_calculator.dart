import 'package:equatable/equatable.dart';
import 'package:game_2048/ai/genetic/genetic_manager.dart';
import 'package:game_2048/board/board.dart';

class ScoreCalculator {
  late ScoreWeights weights;

  void setupWeights(ScoreWeights weights) {
    this.weights = weights;
  }

  double calculate(ScoreCalculatorModel model) {
    final double points = model.board.getScore() / 15000;
    final emptyTiles = 16 - model.board.array.items.values.length;
    final int notMerged = model.board.array.items.values
        .where((element) => !element.isSingle)
        .length;
    final clustering = calculateClustering(model.board);

    return points * weights.newPoints.value -
        notMerged * weights.merging.value +
        emptyTiles * weights.emptyTiles.value +
        clustering * weights.clustering.value;
  }

  double calculateClustering(Board board) {
    int clusteringScore = 0;

    List<int> neighbors = [-1, 0, 1];

    for (var y = 0; y < 4; y++) {
      for (var x = 0; x < 4; x++) {
        final item = board.array.get(x, y)?.firstOrNull;
        if (item != null) {
          int numOfNeighbors = 0;
          int sum = 0;
          for (int xN in neighbors) {
            int sx = y + xN;
            if (sx < 0 || sx >= 4) {
              continue;
            }
            for (int yN in neighbors) {
              int sy = x + yN;
              if (sy < 0 || sy >= 4) {
                continue;
              }

              final v = board.array.get(sx, sy)?.firstOrNull?.value;
              if (v != null && v > 0) {
                ++numOfNeighbors;
                sum += (item.value - v).abs();
              }
            }
          }

          if (numOfNeighbors > 0) {
            clusteringScore += sum ~/ numOfNeighbors;
          }
        }
      }
    }
    return 1 / (clusteringScore + 1);
  }
}

class ScoreCalculatorModel extends Equatable {
  final Board board;

  const ScoreCalculatorModel(this.board);

  @override
  List<Object?> get props => [board];
}
