import 'package:flutter_test/flutter_test.dart';
import 'package:my_eyes/data/models/eye_measurement_model.dart';
import 'package:my_eyes/data/models/prescription_model.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';
import 'package:my_eyes/domain/entities/prescription.dart';

void main() {
  final tEyeModel = EyeMeasurementModel(
    sphere: -2.5,
    cylinder: -0.75,
    axis: 180,
    addition: 0.0,
    pd: 62.0,
  );

  final tEyeEntity = EyeMeasurement(
    sphere: -2.5,
    cylinder: -0.75,
    axis: 180,
    addition: 0.0,
    pd: 62.0,
  );

  final tDate = DateTime(2024, 1, 15);

  final tModel = PrescriptionModel(
    id: 'p1',
    label: 'Test Prescription',
    issueDate: tDate,
    rightEye: tEyeModel,
    leftEye: tEyeModel,
    updatedAt: tDate,
    pendingSync: true,
  );

  final tEntity = Prescription(
    id: 'p1',
    label: 'Test Prescription',
    issueDate: tDate,
    rightEye: tEyeEntity,
    leftEye: tEyeEntity,
    updatedAt: tDate,
  );

  group('EyeMeasurementModel', () {
    test('toEntity returns correct EyeMeasurement', () {
      expect(tEyeModel.toEntity(), equals(tEyeEntity));
    });

    test('fromEntity creates correct model', () {
      final model = EyeMeasurementModel.fromEntity(tEyeEntity);
      expect(model.sphere, tEyeEntity.sphere);
      expect(model.cylinder, tEyeEntity.cylinder);
      expect(model.axis, tEyeEntity.axis);
      expect(model.addition, tEyeEntity.addition);
      expect(model.pd, tEyeEntity.pd);
    });
  });

  group('PrescriptionModel', () {
    test('toEntity returns correct Prescription', () {
      expect(tModel.toEntity(), equals(tEntity));
    });

    test('fromEntity creates model with pendingSync true', () {
      final model = PrescriptionModel.fromEntity(tEntity);
      expect(model.id, tEntity.id);
      expect(model.label, tEntity.label);
      expect(model.issueDate, tEntity.issueDate);
      expect(model.pendingSync, isTrue);
    });

    test('round-trip: fromEntity then toEntity equals original', () {
      final roundTripped = PrescriptionModel.fromEntity(tEntity).toEntity();
      expect(roundTripped, equals(tEntity));
    });
  });
}
