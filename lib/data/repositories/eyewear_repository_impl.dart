import 'package:injectable/injectable.dart';
import 'package:my_eyes/data/datasources/eyewear_local_datasource.dart';
import 'package:my_eyes/data/models/eyewear_item_model.dart';
import 'package:my_eyes/domain/entities/eyewear_item.dart';
import 'package:my_eyes/domain/repositories/eyewear_repository.dart';

@LazySingleton(as: EyewearRepository)
class EyewearRepositoryImpl implements EyewearRepository {
  EyewearRepositoryImpl(this._localDataSource);

  final EyewearLocalDataSource _localDataSource;

  @override
  Future<List<EyewearItem>> getAll() async {
    final models = await _localDataSource.getAll();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> save(EyewearItem item) =>
      _localDataSource.save(EyewearItemModel.fromEntity(item));

  @override
  Future<void> update(EyewearItem item) =>
      _localDataSource.update(EyewearItemModel.fromEntity(item));

  @override
  Future<void> delete(String id) => _localDataSource.delete(id);
}
