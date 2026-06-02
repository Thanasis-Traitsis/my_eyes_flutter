import 'package:injectable/injectable.dart';
import 'package:my_eyes/data/datasources/eyewear_test_local_datasource.dart';
import 'package:my_eyes/data/models/eyewear_test_model.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';
import 'package:my_eyes/domain/enums/test_filter_key.dart';
import 'package:my_eyes/domain/repositories/eyewear_test_repository.dart';

@LazySingleton(as: EyewearTestRepository)
class EyewearTestRepositoryImpl implements EyewearTestRepository {
  EyewearTestRepositoryImpl(this._localDataSource);

  final EyewearTestLocalDataSource _localDataSource;

  @override
  Future<List<EyewearTest>> getTests({
    Map<TestFilterKey, Set<String>> filters = const {},
  }) async {
    final models = await _localDataSource.getTests(filters: filters);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<EyewearTest>> getTestsPaged({
    Map<TestFilterKey, Set<String>> filters = const {},
    required int offset,
    required int limit,
  }) async {
    final models = await _localDataSource.getTestsPaged(
      filters: filters,
      offset: offset,
      limit: limit,
    );
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<int> getCount() async => _localDataSource.count();

  @override
  Future<void> saveTest(EyewearTest test) =>
      _localDataSource.save(EyewearTestModel.fromEntity(test));

  @override
  Future<void> clearAllTests() => _localDataSource.clearAll();
}
