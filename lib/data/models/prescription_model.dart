import 'package:hive_ce/hive.dart';
import 'package:my_eyes/data/models/eye_measurement_model.dart';
import 'package:my_eyes/domain/entities/prescription.dart';

part 'prescription_model.g.dart';

@HiveType(typeId: 0)
class PrescriptionModel extends HiveObject {
  PrescriptionModel({
    required this.id,
    required this.label,
    required this.issueDate,
    required this.rightEye,
    required this.leftEye,
    required this.updatedAt,
    this.pendingSync = true,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String label;

  @HiveField(2)
  DateTime issueDate;

  @HiveField(3)
  EyeMeasurementModel rightEye;

  @HiveField(4)
  EyeMeasurementModel leftEye;

  @HiveField(5)
  DateTime updatedAt;

  @HiveField(6)
  bool pendingSync;

  Prescription toEntity() => Prescription(
    id: id,
    label: label,
    issueDate: issueDate,
    rightEye: rightEye.toEntity(),
    leftEye: leftEye.toEntity(),
    updatedAt: updatedAt,
  );

  factory PrescriptionModel.fromEntity(Prescription p) => PrescriptionModel(
    id: p.id,
    label: p.label,
    issueDate: p.issueDate,
    rightEye: EyeMeasurementModel.fromEntity(p.rightEye),
    leftEye: EyeMeasurementModel.fromEntity(p.leftEye),
    updatedAt: p.updatedAt,
    pendingSync: true,
  );
}
