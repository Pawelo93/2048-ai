import 'package:equatable/equatable.dart';
import 'package:game_2048/ai/genetic/genetic_manager.dart';
import 'package:game_2048/board/board.dart';
import 'package:game_2048/board/tile/tile.dart';

class ScoreCalculator {
  late ScoreWeights weights;

  void setupWeights(ScoreWeights weights) {
    this.weights = weights;
  }

  double calculate(ScoreCalculatorModel model) {
    final double points = model.board.getScore() / 15000;
    final emptyTiles = (16 - model.board.array.items.values.length) / 16;
    // final int notMerged = model.board.array.items.values
    //     .where((element) => !element.isSingle)
    //     .length;
    final allValues = List.of(model.board.array.items.values.where((element) => element.firstOrNull != null).map((e) => e.firstOrNull!).map((e) => e.value));
    allValues.sort((a, b) => b.compareTo(a));
    final highestValue = allValues.first;
    final hv2 = allValues[1];
    int? hv3 = null;
    try {
      hv3 = allValues[2];
    } catch(e) {}
    double gradientSum = 0;
    gradientSum += model.board.array.get(3, 3)?.firstOrNull?.value == highestValue ? 0.5 : 0;
    gradientSum += model.board.array.get(3, 2)?.firstOrNull?.value == hv2 ? 0.3 : 0;
    if (hv3 != null) {
      gradientSum += model.board.array
          .get(3, 1)
          ?.firstOrNull
          ?.value == hv3 ? 0.2 : 0;
    }

    final clustering = calculateClustering(model.board);

    // print('\n'
    //     'points ${points * weights.newPoints.value} \n'
    //     'gradient ${gradientSum * weights.valuesGradient.value} \n'
    //     'emptyTiles ${emptyTiles * weights.emptyTiles.value} \n'
    //     'clustering ${clustering * weights.clustering.value} \n');

    return points * weights.newPoints.value +
        gradientSum * weights.valuesGradient.value +
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
