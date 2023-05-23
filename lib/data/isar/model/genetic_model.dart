import 'package:isar/isar.dart';

part 'genetic_model.g.dart';

@collection
class GeneticModel {
  final Id id;
  final List<Weights> weights;

  GeneticModel(this.id, this.weights);
}

@embedded
class Weights {
  double? w1;
  double? w2;
  int? generation;
  int? score;

  Weights({this.w1, this.w2, this.generation, this.score});
}
