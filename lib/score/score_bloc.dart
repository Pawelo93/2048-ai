import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreState extends Equatable {
  final int score;
  final int addedValue;
  final int bestScore;

  const ScoreState(
      {required this.score, required this.addedValue, required this.bestScore,});

  factory ScoreState.initial() =>
      const ScoreState(score: 0, addedValue: 0, bestScore: 0,);

  ScoreState copyWith({int? score, int? addedValue, int? bestScore}) {
    return ScoreState(
      score: score ?? this.score,
      addedValue: addedValue ?? this.addedValue,
      bestScore: bestScore ?? this.bestScore,
    );
  }

  ScoreState add(int addToScore) {
    return ScoreState(
        score: score + addToScore,
        addedValue: addToScore,
        bestScore: bestScore,
    );
  }

  @override
  List<Object?> get props => [score, addedValue, bestScore];
}

class ScoreBloc extends Cubit<ScoreState> {
  ScoreBloc() : super(ScoreState.initial());

  void load() {
    // TODO LOAD BEST SCORE
  }

  void addScore(int addedValue) {
    emit(state.add(addedValue));
  }

  void updateBestScore() {
    // TODO SAVE BEST SCORE
    emit(state.copyWith(bestScore: state.score));
  }

  void clear() {
    emit(state.copyWith(score: 0, addedValue: 0));
  }
}