import 'package:flutter_test/flutter_test.dart';
import 'package:my_eyes/core/validators/field_validator.dart';

class _TestValidator extends OptionalAwareValidator {
  const _TestValidator({super.isOptional});

  @override
  ValidationResult validateValue(String value) {
    if (value == 'valid') return const ValidationValid();
    return const ValidationInvalid('invalid value');
  }
}

void main() {
  group('ValidationResult', () {
    test('ValidationValid is a ValidationResult', () {
      const result = ValidationValid();
      expect(result, isA<ValidationResult>());
    });

    test('ValidationInvalid carries a message', () {
      const result = ValidationInvalid('some error');
      expect(result, isA<ValidationResult>());
      expect(result.message, 'some error');
    });
  });

  group('OptionalAwareValidator — required (default)', () {
    const validator = _TestValidator();

    test('isRequired is true when isOptional is false', () {
      expect(validator.isRequired, isTrue);
      expect(validator.isOptional, isFalse);
    });

    test('returns ValidationInvalid for empty string', () {
      final result = validator.validate('');
      expect(result, isA<ValidationInvalid>());
    });

    test('returns ValidationInvalid for whitespace-only string', () {
      final result = validator.validate('   ');
      expect(result, isA<ValidationInvalid>());
    });

    test('delegates to validateValue for non-empty string', () {
      final result = validator.validate('valid');
      expect(result, isA<ValidationValid>());
    });

    test('returns invalid when validateValue returns invalid', () {
      final result = validator.validate('bad');
      expect(result, isA<ValidationInvalid>());
    });
  });

  group('OptionalAwareValidator — optional', () {
    const validator = _TestValidator(isOptional: true);

    test('isOptional is true', () {
      expect(validator.isOptional, isTrue);
      expect(validator.isRequired, isFalse);
    });

    test('returns ValidationValid for empty string', () {
      final result = validator.validate('');
      expect(result, isA<ValidationValid>());
    });

    test('returns ValidationValid for whitespace-only string', () {
      final result = validator.validate('   ');
      expect(result, isA<ValidationValid>());
    });

    test('delegates to validateValue for non-empty string', () {
      final result = validator.validate('valid');
      expect(result, isA<ValidationValid>());
    });

    test('returns invalid when non-empty value fails validateValue', () {
      final result = validator.validate('bad');
      expect(result, isA<ValidationInvalid>());
    });
  });
}
