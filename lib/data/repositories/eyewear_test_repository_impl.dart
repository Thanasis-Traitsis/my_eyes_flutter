import 'package:injectable/injectable.dart';
import 'package:my_eyes/data/datasources/eyewear_test_local_datasource.dart';
import 'package:my_eyes/data/models/eyewear_test_model.dart';
import 'package:my_eyes/domain/entities/eyewear_test.dart';
import 'package:my_eyes/domain/repositories/eyewear_test_repository.dart';

@LazySingleton(as: EyewearTestRepository)
class EyewearTestRepositoryImpl implements EyewearTestRepository {
  EyewearTestRepositoryImpl(this._localDataSource);

  final EyewearTestLocalDataSource _localDataSource;

  @override
  Future<List<EyewearTest>> getTests({String? eyewearId}) async {
    final models = await _localDataSource.getTests(eyewearId: eyewearId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> saveTest(EyewearTest test) =>
      _localDataSource.save(EyewearTestModel.fromEntity(test));
}
