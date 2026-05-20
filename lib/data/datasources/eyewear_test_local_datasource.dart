import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:my_eyes/data/models/eyewear_test_model.dart';

abstract class EyewearTestLocalDataSource {
  Future<List<EyewearTestModel>> getTests({Set<String> eyewearIds = const {}});

  Future<List<EyewearTestModel>> getTestsPaged({
    Set<String> eyewearIds = const {},
    required int offset,
    required int limit,
  });

  Future<void> save(EyewearTestModel model);
}

@LazySingleton(as: EyewearTestLocalDataSource)
class HiveEyewearTestLocalDataSource implements EyewearTestLocalDataSource {
  HiveEyewearTestLocalDataSource(this._box);

  final Box<EyewearTestModel> _box;

  @override
  Future<List<EyewearTestModel>> getTests({
    Set<String> eyewearIds = const {},
  }) async {
    final values = eyewearIds.isEmpty
        ? _box.values.toList()
        : _box.values.where((m) => eyewearIds.contains(m.eyewearId)).toList();
    values.sort((a, b) => b.takenAt.compareTo(a.takenAt));
    return values;
  }

  @override
  Future<List<EyewearTestModel>> getTestsPaged({
    Set<String> eyewearIds = const {},
    required int offset,
    required int limit,
  }) async {
    final all = await getTests(eyewearIds: eyewearIds);
    return all.skip(offset).take(limit).toList();
  }

  @override
  Future<void> save(EyewearTestModel model) => _box.put(model.id, model);
}
