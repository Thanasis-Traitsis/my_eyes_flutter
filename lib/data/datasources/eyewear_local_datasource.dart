import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:my_eyes/data/models/eyewear_item_model.dart';

abstract class EyewearLocalDataSource {
  Future<List<EyewearItemModel>> getAll();
  Future<void> save(EyewearItemModel model);
  Future<void> update(EyewearItemModel model);
  Future<void> delete(String id);
}

@LazySingleton(as: EyewearLocalDataSource)
class HiveEyewearLocalDataSource implements EyewearLocalDataSource {
  HiveEyewearLocalDataSource(this._box);

  final Box<EyewearItemModel> _box;

  @override
  Future<List<EyewearItemModel>> getAll() async {
    final values = _box.values.toList();
    values.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return values;
  }

  @override
  Future<void> save(EyewearItemModel model) => _box.put(model.id, model);

  @override
  Future<void> update(EyewearItemModel model) => _box.put(model.id, model);

  @override
  Future<void> delete(String id) => _box.delete(id);
}
