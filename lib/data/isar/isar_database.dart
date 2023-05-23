import 'package:game_2048/data/isar/model/genetic_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabase {
  late Isar _isar;

  Future<void> open() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        GeneticModelSchema,
      ],
      directory: dir.path,
    );
  }

  Future<void> add(String id, Weights weights) async {
    final Id isarId = Id.parse(id);
    if (await _isar.geneticModels.get(isarId) != null) {
      final model = (await _isar.geneticModels.get(isarId));
      if (model != null) {
        final newModel = GeneticModel(model.id, List.of(model.weights)..add(weights));

        _isar.writeTxn(() {
          return _isar.geneticModels.put(newModel);
        });
      }
    } else {
      return _isar.writeTxn(() {
        return _isar.geneticModels.put(GeneticModel(isarId, [weights]));
      });
    }
    // return _isar.writeTxn(() => _isar.geneticModels.get(id).then((value) => value)put(geneticModel));
  }

  int fastHash(String string) {
    var hash = 0xcbf29ce484222325;

    var i = 0;
    while (i < string.length) {
      final codeUnit = string.codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }

    return hash;
  }
}