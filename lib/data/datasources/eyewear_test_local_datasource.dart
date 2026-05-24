import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:my_eyes/data/models/eyewear_test_model.dart';
import 'package:my_eyes/domain/enums/test_filter_key.dart';

abstract class EyewearTestLocalDataSource {
  Future<List<EyewearTestModel>> getTests({
    Map<TestFilterKey, Set<String>> filters = const {},
  });

  Future<List<EyewearTestModel>> getTestsPaged({
    Map<TestFilterKey, Set<String>> filters = const {},
    required int offset,
    required int limit,
  });

  Future<void> save(EyewearTestModel model);
  Future<void> clearAll();
}

@LazySingleton(as: EyewearTestLocalDataSource)
class HiveEyewearTestLocalDataSource implements EyewearTestLocalDataSource {
  HiveEyewearTestLocalDataSource(this._box);

  final Box<EyewearTestModel> _box;

  @override
  Future<List<EyewearTestModel>> getTests({
    Map<TestFilterKey, Set<String>> filters = const {},
  }) async {
    var values = _box.values.toList();

    for (final entry in filters.entries) {
      if (entry.value.isEmpty) continue;
      switch (entry.key) {
        case TestFilterKey.eyewearId:
          values = values
              .where((m) => entry.value.contains(m.eyewearId))
              .toList();
      }
    }

    values.sort((a, b) => b.takenAt.compareTo(a.takenAt));
    return values;
  }

  @override
  Future<List<EyewearTestModel>> getTestsPaged({
    Map<TestFilterKey, Set<String>> filters = const {},
    required int offset,
    required int limit,
  }) async {
    final all = await getTests(filters: filters);
    return all.skip(offset).take(limit).toList();
  }

  @override
  Future<void> save(EyewearTestModel model) => _box.put(model.id, model);

  @override
  Future<void> clearAll() => _box.clear();
}
