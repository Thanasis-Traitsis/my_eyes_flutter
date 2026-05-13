import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:my_eyes/data/models/eyewear_test_model.dart';

abstract class EyewearTestLocalDataSource {
  Future<List<EyewearTestModel>> getTests({String? eyewearId});

  Future<void> save(EyewearTestModel model);
}

@LazySingleton(as: EyewearTestLocalDataSource)
class HiveEyewearTestLocalDataSource implements EyewearTestLocalDataSource {
  HiveEyewearTestLocalDataSource(this._box);

  final Box<EyewearTestModel> _box;

  @override
  Future<List<EyewearTestModel>> getTests({String? eyewearId}) async {
    final values = eyewearId == null
        ? _box.values.toList()
        : _box.values.where((m) => m.eyewearId == eyewearId).toList();
    values.sort((a, b) => b.takenAt.compareTo(a.takenAt));
    return values;
  }

  @override
  Future<void> save(EyewearTestModel model) => _box.put(model.id, model);
}
