import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:my_eyes/data/models/prescription_model.dart';

abstract class PrescriptionLocalDataSource {
  Future<List<PrescriptionModel>> getAll();
  Future<void> save(PrescriptionModel model);
  Future<void> update(PrescriptionModel model);
  Future<void> delete(String id);
}

@LazySingleton(as: PrescriptionLocalDataSource)
class HivePrescriptionLocalDataSource implements PrescriptionLocalDataSource {
  HivePrescriptionLocalDataSource(this._box);

  final Box<PrescriptionModel> _box;

  @override
  Future<List<PrescriptionModel>> getAll() async {
    final values = _box.values.toList();
    values.sort((a, b) => b.issueDate.compareTo(a.issueDate));
    return values;
  }

  @override
  Future<void> save(PrescriptionModel model) => _box.put(model.id, model);

  @override
  Future<void> update(PrescriptionModel model) => _box.put(model.id, model);

  @override
  Future<void> delete(String id) => _box.delete(id);
}
