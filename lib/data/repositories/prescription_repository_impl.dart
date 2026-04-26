import 'package:injectable/injectable.dart';
import 'package:my_eyes/data/datasources/prescription_local_datasource.dart';
import 'package:my_eyes/data/models/prescription_model.dart';
import 'package:my_eyes/domain/entities/prescription.dart';
import 'package:my_eyes/domain/repositories/prescription_repository.dart';

@LazySingleton(as: PrescriptionRepository)
class PrescriptionRepositoryImpl implements PrescriptionRepository {
  PrescriptionRepositoryImpl(this._localDataSource);

  final PrescriptionLocalDataSource _localDataSource;

  @override
  Future<List<Prescription>> getPrescriptions() async {
    final models = await _localDataSource.getAll();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> savePrescription(Prescription prescription) =>
      _localDataSource.save(PrescriptionModel.fromEntity(prescription));

  @override
  Future<void> updatePrescription(Prescription prescription) =>
      _localDataSource.update(PrescriptionModel.fromEntity(prescription));

  @override
  Future<void> deletePrescription(String id) => _localDataSource.delete(id);
}
