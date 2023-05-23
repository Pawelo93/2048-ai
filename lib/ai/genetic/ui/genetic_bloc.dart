import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/ai/genetic/genetic_manager.dart';

class GeneticState extends Equatable {
  final List<ScoreWeights> weightsList;
  final int index;
  final int allWeightsCount;
  final List<FitnessElement> fitnessElements;

  const GeneticState(this.weightsList, this.index, this.allWeightsCount, this.fitnessElements);

  ScoreWeights? get currentWeights => index >= 0 ? weightsList[index] : null;

  @override
  List<Object?> get props => [weightsList, index, allWeightsCount, fitnessElements,];
}

class GeneticBloc extends Cubit<GeneticState> {
  final GeneticManager _geneticManager = GeneticManager();

  GeneticBloc() : super(GeneticState([], -1, 0, []));

  void start() {
    final weights = _geneticManager.generateStartGeneration();
    emit(GeneticState(weights, 0, weights.length, []));
  }

  void end(int gameScore) {
    final currentWeights = state.currentWeights;
    if (currentWeights == null) {
      return;
    }

    final nextIndex = state.index + 1;
    if (nextIndex < state.allWeightsCount) {
      final fitnessElements = List.of(state.fitnessElements)..add(FitnessElement(currentWeights, gameScore));
      emit(GeneticState(state.weightsList, nextIndex, state.allWeightsCount, fitnessElements));
    } else {
      // generation is over
      final nextGeneration = _geneticManager.generateNextGeneration(state.weightsList, state.fitnessElements);
      emit(GeneticState(nextGeneration, 0, nextGeneration.length, []));
    }
  }

  void terminate() {
    emit(GeneticState([], -1, 0, []));
  }
}