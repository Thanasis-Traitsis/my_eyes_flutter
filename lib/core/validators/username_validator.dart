import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/validators/field_validator.dart';

class UsernameValidator extends OptionalAwareValidator {
  const UsernameValidator({super.isOptional});

  static const _minLength = 3;
  static const _maxLength = 30;

  @override
  ValidationResult validateValue(String value) {
    final trimmed = value.trim();

    if (trimmed.length < _minLength) {
      return ValidationInvalid(
        AppStrings.validatorInvalidUsernameShort(_minLength),
      );
    }
    if (trimmed.length > _maxLength) {
      return ValidationInvalid(
        AppStrings.validatorInvalidUsernameLong(_maxLength),
      );
    }

    return const ValidationValid();
  }
}
