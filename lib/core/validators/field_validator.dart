sealed class ValidationResult {
  const ValidationResult();
}

final class ValidationValid extends ValidationResult {
  const ValidationValid();
}

final class ValidationInvalid extends ValidationResult {
  const ValidationInvalid(this.message);
  final String message;
}

abstract interface class FieldValidator {
  ValidationResult validate(String value);
}

abstract class OptionalAwareValidator implements FieldValidator {
  const OptionalAwareValidator({this.isOptional = false});

  final bool isOptional;
  bool get isRequired => !isOptional;

  @override
  ValidationResult validate(String value) {
    if (isOptional && value.trim().isEmpty) return const ValidationValid();
    return validateValue(value);
  }

  ValidationResult validateValue(String value);
}
