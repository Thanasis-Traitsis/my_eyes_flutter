import 'package:my_eyes/domain/entities/prescription.dart';

abstract class PrescriptionRepository {
  Future<List<Prescription>> getPrescriptions();
  Future<void> savePrescription(Prescription prescription);
  Future<void> updatePrescription(Prescription prescription);
  Future<void> deletePrescription(String id);
}
