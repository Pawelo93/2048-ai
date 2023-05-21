import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/data/best_score_repository.dart';

class ScoreState extends Equatable {
  final int score;
  final int addedValue;
  final int bestScore;

  const ScoreState({
    required this.score,
    required this.addedValue,
    required this.bestScore,
  });

  factory ScoreState.initial() => const ScoreState(
        score: 0,
        addedValue: 0,
        bestScore: 0,
      );

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
  final BestScoreRepository _bestScoreRepository = BestScoreRepository();

  ScoreBloc() : super(ScoreState.initial());

  void load() async {
    final bestScore = await _bestScoreRepository.get();
    emit(state.copyWith(bestScore: bestScore));
  }

  void addScore(int addedValue) {
    emit(state.add(addedValue));
  }

  void updateBestScore() async {
    final bestScore = state.score;
    emit(state.copyWith(bestScore: bestScore));
    await _bestScoreRepository.set(bestScore);
  }

  void clear() {
    emit(state.copyWith(score: 0, addedValue: 0));
  }
}
