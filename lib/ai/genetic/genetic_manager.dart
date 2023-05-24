import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:game_2048/data/isar/isar_database.dart';
import 'package:game_2048/data/isar/model/genetic_model.dart';

typedef PlayGameContract = Future<double> Function(ScoreWeights weights);

class GeneticManager {
  int generation = 0;
  int totalPopulation = 100;

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
          w1: Weight(random.nextDouble()),
          w2: Weight(random.nextDouble()),
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
        w1: best.weights.w1.value,
        w2: best.weights.w2.value,
        generation: generation,
        score: bscore,
      ),
    );
    print(
        'BEST SCORE ${bscore} generation ${generation} currentBestScore (${currentBestScore})');

    final nextGeneration = reproduction(fitnessElements);

    return nextGeneration;
  }

  int bestScore(List<FitnessElement> generation) {
    return generation.map((element) => element.fitness).reduce(max);
  }

  // Future<List<FitnessElement>> calculateFitness(List<ScoreWeights> scoreWeights) async {
  //   final List<FitnessElement> fitnessElements = [];
  //   for (final weights in scoreWeights) {
  //     final gameScore = await playGameContract(weights);
  //     fitnessElements.add(FitnessElement(weights, gameScore));
  //   }
  //
  //   return fitnessElements;
  // }

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

    final rand = random.nextBool();
    final newW1 = rand ? first.weights.w1 : second.weights.w1;
    final newW2 = rand ? second.weights.w2 : first.weights.w2;
    // final newW1 = (first.w1.value + second.w1.value) / 2;
    // final newW2 = (first.w2.value + second.w2.value) / 2;
    final newWeights = ScoreWeights(w1: newW1, w2: newW2);

    // TODO MUTATION
    // newItem = doMutation(random, newItem)

    return newWeights;
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
  final Weight w1;
  final Weight w2;

  const ScoreWeights({
    required this.w1,
    required this.w2,
  });

  @override
  List<Object?> get props => [w1];
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
