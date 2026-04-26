import 'package:flutter_test/flutter_test.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/validators/field_validator.dart';
import 'package:my_eyes/core/validators/prescription_validator.dart';

void main() {
  // ---------------------------------------------------------------------------
  // SphereValidator
  // ---------------------------------------------------------------------------
  group('SphereValidator (required)', () {
    const validator = SphereValidator();

    test('returns invalid for empty string', () {
      final result = validator.validate('');
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidPrescriptionOnlyNum,
      );
    });

    test('returns invalid for non-numeric input', () {
      final result = validator.validate('abc');
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidPrescriptionOnlyNum,
      );
    });

    test('returns invalid below -30', () {
      final result = validator.validate('-30.25');
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidPrescriptionSphereValue,
      );
    });

    test('returns invalid above +30', () {
      final result = validator.validate('30.25');
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidPrescriptionSphereValue,
      );
    });

    test('returns valid at boundary -30.0', () {
      expect(validator.validate('-30.0'), isA<ValidationValid>());
    });

    test('returns valid at boundary +30.0', () {
      expect(validator.validate('30.0'), isA<ValidationValid>());
    });

    test('returns valid for a typical value like -1.75', () {
      expect(validator.validate('-1.75'), isA<ValidationValid>());
    });

    test('returns valid for zero', () {
      expect(validator.validate('0'), isA<ValidationValid>());
    });
  });

  // ---------------------------------------------------------------------------
  // CylinderValidator
  // ---------------------------------------------------------------------------
  group('CylinderValidator (required)', () {
    const validator = CylinderValidator();

    test('returns invalid for empty string', () {
      final result = validator.validate('');
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidPrescriptionOnlyNum,
      );
    });

    test('returns invalid for non-numeric input', () {
      final result = validator.validate('xyz');
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidPrescriptionOnlyNum,
      );
    });

    test('returns invalid below -10', () {
      final result = validator.validate('-10.5');
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidPrescriptionCylinderValue,
      );
    });

    test('returns invalid above +10', () {
      final result = validator.validate('10.5');
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidPrescriptionCylinderValue,
      );
    });

    test('returns valid at boundary -10.0', () {
      expect(validator.validate('-10.0'), isA<ValidationValid>());
    });

    test('returns valid at boundary +10.0', () {
      expect(validator.validate('10.0'), isA<ValidationValid>());
    });

    test('returns valid for a typical value like -0.75', () {
      expect(validator.validate('-0.75'), isA<ValidationValid>());
    });

    test('returns valid for zero', () {
      expect(validator.validate('0'), isA<ValidationValid>());
    });
  });

  // ---------------------------------------------------------------------------
  // AxisValidator
  // ---------------------------------------------------------------------------
  group('AxisValidator (required)', () {
    const validator = AxisValidator();

    test('returns invalid for empty string', () {
      final result = validator.validate('');
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidPrescriptionOnlyWholeNum,
      );
    });

    test('returns invalid for non-integer input', () {
      final result = validator.validate('45.5');
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidPrescriptionOnlyWholeNum,
      );
    });

    test('returns invalid for non-numeric input', () {
      final result = validator.validate('abc');
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidPrescriptionOnlyWholeNum,
      );
    });

    test('returns invalid below 0', () {
      final result = validator.validate('-1');
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidPrescriptionAxisValue,
      );
    });

    test('returns invalid above 180', () {
      final result = validator.validate('181');
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidPrescriptionAxisValue,
      );
    });

    test('returns valid at boundary 0', () {
      expect(validator.validate('0'), isA<ValidationValid>());
    });

    test('returns valid at boundary 180', () {
      expect(validator.validate('180'), isA<ValidationValid>());
    });

    test('returns valid for a typical value like 90', () {
      expect(validator.validate('90'), isA<ValidationValid>());
    });
  });
}
