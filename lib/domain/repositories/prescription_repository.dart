import 'package:my_eyes/domain/entities/prescription.dart';

abstract class PrescriptionRepository {
  Future<List<Prescription>> getPrescriptions();
  Future<List<Prescription>> getPrescriptionsPaged({
    required int offset,
    required int limit,
  });
  Future<void> savePrescription(Prescription prescription);
  Future<void> updatePrescription(Prescription prescription);
  Future<void> deletePrescription(String id);
}
