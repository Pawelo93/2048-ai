import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:game_2048/data/isar/isar_database.dart';
import 'package:game_2048/data/isar/model/genetic_model.dart';

typedef PlayGameContract = Future<double> Function(ScoreWeights weights);

class GeneticManager {
  int generation = 0;
  int totalPopulation = 20;
  double mutationRate = 0.15;

  final Random random = Random();
  late PlayGameContract playGameContract;

  final IsarDatabase isarDatabase = IsarDatabase();
  String id = DateTime.now().millisecondsSinceEpoch.toString();

  GeneticManager() {
    isarDatabase.open();
  }

  List<ScoreWeights> generateStartGeneration() {
    final List<ScoreWeights> startGeneration = [];
    for (int i = 0; i < totalPopulation; i++) {
      startGeneration.add(
        ScoreWeights(
          newPoints: Weight(random.nextDouble()),
          merging: Weight(random.nextDouble()),
          emptyTiles: Weight(random.nextDouble()),
          clustering: Weight(random.nextDouble()),
        ),
      );
    }

    return startGeneration;
  }

  int currentBestScore = 0;

  List<ScoreWeights> generateNextGeneration(
    List<ScoreWeights> previousGeneration,
    List<FitnessElement> fitnessElements,
  ) {
    generation++;

    final bscore = bestScore(fitnessElements);
    if (bscore > currentBestScore) {
      currentBestScore = bscore;
    }
    final best =
        fitnessElements.where((element) => element.fitness == bscore).first;
    isarDatabase.add(
      id,
      Weights(
        w1: best.weights.newPoints.value,
        w2: best.weights.merging.value,
        w3: best.weights.emptyTiles.value,
        w4: best.weights.clustering.value,
        generation: generation,
        score: bscore,
      ),
    );
    print('');
    print('BEST SCORE ${bscore} generation ${generation} (BS ${currentBestScore})');
    showWeights(best.weights);
    print('');

    final nextGeneration = reproduction(fitnessElements);

    return nextGeneration;
  }

  void showWeights(ScoreWeights weights) {
    print('== NewPoints: ${weights.newPoints.value.toStringAsFixed(2)} ');
    print('== Merging: ${weights.merging.value.toStringAsFixed(2)} ');
    print('== EmptyTiles: ${weights.emptyTiles.value.toStringAsFixed(2)} ');
    print('== Clustering: ${weights.clustering.value.toStringAsFixed(2)} ');
  }

  int bestScore(List<FitnessElement> generation) {
    return generation.map((element) => element.fitness).reduce(max);
  }

  List<ScoreWeights> reproduction(List<FitnessElement> fitnessElements) {
    final List<FitnessElement> listOfWeights = [];
    final biggestItem = fitnessElements.map((e) => e.fitness).reduce(max);

    for (final element in fitnessElements) {
      final fit = element.fitness / biggestItem;
      int count = (fit * 10).toInt();
      if (count == 0) {
        count = 1;
      }
      for (int i = 0; i < count; i++) {
        listOfWeights.add(element);
      }
    }

    final List<ScoreWeights> output = [];

    for (var i = 0; i < totalPopulation; i++) {
      output.add(reproductionCrossover(listOfWeights));
    }

    return output;
  }

  ScoreWeights reproductionCrossover(List<FitnessElement> listOfWeights) {
    final randomItemIndex = random.nextInt(listOfWeights.length);
    final first = listOfWeights[randomItemIndex];
    FitnessElement second;
    int i = 0;
    do {
      second = listOfWeights[random.nextInt(listOfWeights.length)];
      i++;
    } while (first == second && i < listOfWeights.length);

    final rand1 = random.nextBool();
    final rand2 = random.nextBool();
    final newNewPoints =
        rand1 ? first.weights.newPoints : second.weights.newPoints;
    final newMerging = rand1 ? second.weights.merging : first.weights.merging;
    final newEmptyTiles =
        rand2 ? first.weights.emptyTiles : second.weights.emptyTiles;
    final newClustering =
        rand2 ? second.weights.clustering : first.weights.clustering;

    ScoreWeights newWeights = ScoreWeights(
      newPoints: newNewPoints,
      merging: newMerging,
      emptyTiles: newEmptyTiles,
      clustering: newClustering,
    );

    if (random.nextDouble() < mutationRate) {
      newWeights = mutate(newWeights);
    }

    return newWeights;
  }

  ScoreWeights mutate(ScoreWeights scoreWeights) {
    final addOrSubtractMutation1 = random.nextBool();
    final addOrSubtractMutation2 = random.nextBool();
    final mutationW1 = random.nextDouble() * 0.1;
    final mutationW2 = random.nextDouble() * 0.1;
    final mutationW3 = random.nextDouble() * 0.1;
    final mutationW4 = random.nextDouble() * 0.1;

    double newPointsMutated = addOrSubtractMutation1
        ? scoreWeights.newPoints.value + mutationW1
        : scoreWeights.newPoints.value - mutationW1;
    double mergingMutated = addOrSubtractMutation2
        ? scoreWeights.merging.value + mutationW2
        : scoreWeights.merging.value - mutationW2;
    double emptyTilesMutated = addOrSubtractMutation2
        ? scoreWeights.emptyTiles.value + mutationW3
        : scoreWeights.emptyTiles.value - mutationW3;
    double clusteringMutated = addOrSubtractMutation2
        ? scoreWeights.clustering.value + mutationW4
        : scoreWeights.clustering.value - mutationW4;

    final afterMutation = ScoreWeights(
      newPoints: Weight(normalized(newPointsMutated)),
      merging: Weight(normalized(mergingMutated)),
      emptyTiles: Weight(normalized(emptyTilesMutated)),
      clustering: Weight(normalized(clusteringMutated)),
    );
    // print('WEIGHTS BEFORE MUTATION $scoreWeights   --- after $afterMutation');

    return afterMutation;
  }

  double normalized(double value) {
    if (value > 1) {
      return 1;
    } else if (value < 0) {
      return 0;
    }

    return value;
  }

  T randomChoice<T>(Iterable<T> options,
      [Iterable<double> weights = const []]) {
    if (options.isEmpty) {
      throw ArgumentError.value(
          options.toString(), 'options', 'must be non-empty');
    }
    if (weights.isNotEmpty && options.length != weights.length) {
      throw ArgumentError.value(weights.toString(), 'weights',
          'must be empty or match length of options');
    }

    if (weights.isEmpty) {
      return options.elementAt(Random().nextInt(options.length));
    }

    double sum = weights.reduce((val, curr) => val + curr);
    double randomWeight = Random().nextDouble() * sum;

    int i = 0;
    for (int l = options.length; i < l; i++) {
      randomWeight -= weights.elementAt(i);
      if (randomWeight <= 0) {
        break;
      }
    }

    return options.elementAt(i);
  }
}

class ScoreWeights extends Equatable {
  final Weight newPoints;
  final Weight merging;
  final Weight emptyTiles;
  final Weight clustering;

  const ScoreWeights({
    required this.newPoints,
    required this.merging,
    required this.emptyTiles,
    required this.clustering,
  });

  @override
  List<Object?> get props => [newPoints, merging, emptyTiles, clustering];
}

class Weight extends Equatable {
  final double value;

  const Weight(this.value);

  @override
  List<Object?> get props => [value];
}

class FitnessElement extends Equatable {
  final ScoreWeights weights;
  final int fitness;

  const FitnessElement(this.weights, this.fitness);

  @override
  List<Object?> get props => [weights, fitness];
}
