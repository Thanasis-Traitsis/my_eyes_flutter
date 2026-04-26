import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/validators/field_validator.dart';

class SphereValidator extends OptionalAwareValidator {
  const SphereValidator({super.isOptional});

  @override
  ValidationResult validateValue(String value) {
    final parsed = double.tryParse(value);

    if (parsed == null)
      return const ValidationInvalid(
        AppStrings.validatorInvalidPrescriptionOnlyNum,
      );
    if (parsed < -30.0 || parsed > 30.0) {
      return const ValidationInvalid(
        AppStrings.validatorInvalidPrescriptionSphereValue,
      );
    }
    return const ValidationValid();
  }
}

class CylinderValidator extends OptionalAwareValidator {
  const CylinderValidator({super.isOptional});

  @override
  ValidationResult validateValue(String value) {
    final parsed = double.tryParse(value);

    if (parsed == null)
      return const ValidationInvalid(
        AppStrings.validatorInvalidPrescriptionOnlyNum,
      );
    if (parsed < -10.0 || parsed > 10.0) {
      return const ValidationInvalid(
        AppStrings.validatorInvalidPrescriptionCylinderValue,
      );
    }
    return const ValidationValid();
  }
}

class AxisValidator extends OptionalAwareValidator {
  const AxisValidator({super.isOptional});

  @override
  ValidationResult validateValue(String value) {
    final parsed = int.tryParse(value);

    if (parsed == null)
      return const ValidationInvalid(
        AppStrings.validatorInvalidPrescriptionOnlyWholeNum,
      );
    if (parsed < 0 || parsed > 180) {
      return const ValidationInvalid(
        AppStrings.validatorInvalidPrescriptionAxisValue,
      );
    }
    return const ValidationValid();
  }
}
