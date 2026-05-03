import 'package:flutter_test/flutter_test.dart';
import 'package:my_eyes/core/utils/prescription_extensions.dart';
import 'package:my_eyes/domain/entities/eye_measurement.dart';
import 'package:my_eyes/domain/entities/prescription.dart';

void main() {
  final tDate = DateTime(2024, 1, 15);

  const tRightEye = EyeMeasurement(
    sphere: -2.5,
    cylinder: -0.75,
    axis: 180,
    addition: 0.0,
    pd: 62.0,
  );

  const tLeftEye = EyeMeasurement(
    sphere: -1.0,
    cylinder: -0.5,
    axis: 90,
    addition: 0.0,
    pd: 62.0,
  );

  final tPrescription = Prescription(
    id: 'p1',
    label: 'Test',
    issueDate: tDate,
    rightEye: tRightEye,
    leftEye: tLeftEye,
    updatedAt: tDate,
  );

  group('PrescriptionFormatting', () {
    test('formattedRight formats right eye correctly', () {
      expect(tPrescription.formattedRight, '-2.5 -0.75 x 180');
    });

    test('formattedLeft formats left eye correctly', () {
      expect(tPrescription.formattedLeft, '-1.0 -0.5 x 90');
    });

    test('formattedRight and formattedLeft differ when eyes differ', () {
      expect(tPrescription.formattedRight, isNot(tPrescription.formattedLeft));
    });

    test('format is consistent for same eye values', () {
      final symmetric = Prescription(
        id: 'p2',
        label: 'Symmetric',
        issueDate: tDate,
        rightEye: tRightEye,
        leftEye: tRightEye,
        updatedAt: tDate,
      );
      expect(symmetric.formattedRight, symmetric.formattedLeft);
    });
  });
}
