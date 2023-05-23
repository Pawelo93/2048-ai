import 'package:game_2048/ai/genetic/genetic_manager.dart';
import 'package:game_2048/board/board.dart';

class ScoreCalculator {
  late ScoreWeights weights;

  void setupWeights(ScoreWeights weights) {
    this.weights = weights;
  }

  double calculate(Board board, int points) {
    final lessValuesScore = board.array.items.values.length;
    final twos = board.array.items.values.map((e) => e.tiles[0].value).where((e) => e == 2 || e == 4).toList().length;

    return twos * weights.w1.value - lessValuesScore * weights.w2.value;

    // allValues.sort((a, b) => b.compareTo(a));
    // final highestValue = allValues.first;
    // final secondHighestValue = allValues[1];
    // final twos = board.array.items.values.map((e) => e.tiles[0].value).where((e) => e == 2 || e == 4).toList().length;
    // final isInCornerH1 = board.array.get(3, 3)?.tiles[0].value == highestValue;
    // final isInCornerH2 = board.array.get(3, 2)?.tiles[0].value == secondHighestValue;
    // final inCornerScore = (isInCornerH1 ? 2 : 0) + (isInCornerH2 ? 1 : 0);
    //
    // return -lessValuesScore - twos + inCornerScore;
  }
}

// TODO WEIGHTS SHOULD BE HERE DEFINED AND GENETIC SHOULD USE ABSTRACTION