import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/validators/field_validator.dart';

class EmailValidator extends OptionalAwareValidator {
  const EmailValidator({super.isOptional});

  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  ValidationResult validateValue(String value) {
    final trimmed = value.trim();

    if (!_emailRegex.hasMatch(trimmed)) {
      return const ValidationInvalid(AppStrings.validatorInvalidEmailValue);
    }

    return const ValidationValid();
  }
}
