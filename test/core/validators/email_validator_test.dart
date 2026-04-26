import 'package:flutter_test/flutter_test.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/validators/email_validator.dart';
import 'package:my_eyes/core/validators/field_validator.dart';

void main() {
  group('EmailValidator (required)', () {
    const validator = EmailValidator();

    test('returns invalid for empty string', () {
      final result = validator.validate('');
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidEmailValue,
      );
    });

    test('returns invalid for missing @ symbol', () {
      final result = validator.validate('userexample.com');
      expect(result, isA<ValidationInvalid>());
    });

    test('returns invalid for missing domain', () {
      final result = validator.validate('user@');
      expect(result, isA<ValidationInvalid>());
    });

    test('returns invalid for missing TLD', () {
      final result = validator.validate('user@example');
      expect(result, isA<ValidationInvalid>());
    });

    test('returns invalid for spaces in email', () {
      final result = validator.validate('user @example.com');
      expect(result, isA<ValidationInvalid>());
    });

    test('returns valid for a standard email', () {
      final result = validator.validate('user@example.com');
      expect(result, isA<ValidationValid>());
    });

    test('returns valid for email with subdomain', () {
      final result = validator.validate('user@mail.example.com');
      expect(result, isA<ValidationValid>());
    });

    test('returns valid for email with plus addressing', () {
      final result = validator.validate('user+tag@example.com');
      expect(result, isA<ValidationValid>());
    });

    test('trims surrounding whitespace before validating', () {
      final result = validator.validate('  user@example.com  ');
      expect(result, isA<ValidationValid>());
    });
  });

  group('EmailValidator (optional)', () {
    const validator = EmailValidator(isOptional: true);

    test('returns valid for empty string when optional', () {
      final result = validator.validate('');
      expect(result, isA<ValidationValid>());
    });

    test('returns valid for whitespace-only string when optional', () {
      final result = validator.validate('   ');
      expect(result, isA<ValidationValid>());
    });

    test('still validates non-empty values when optional', () {
      final result = validator.validate('not-an-email');
      expect(result, isA<ValidationInvalid>());
    });
  });
}
