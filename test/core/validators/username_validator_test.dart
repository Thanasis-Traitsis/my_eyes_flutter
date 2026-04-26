import 'package:flutter_test/flutter_test.dart';
import 'package:my_eyes/core/constants/app_strings.dart';
import 'package:my_eyes/core/validators/field_validator.dart';
import 'package:my_eyes/core/validators/username_validator.dart';

void main() {
  group('UsernameValidator (required)', () {
    const validator = UsernameValidator();

    test('returns invalid for empty string', () {
      final result = validator.validate('');
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidUsernameShort(3),
      );
    });

    test('returns invalid when shorter than 3 characters', () {
      final result = validator.validate('ab');
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidUsernameShort(3),
      );
    });

    test('returns invalid when longer than 30 characters', () {
      final result = validator.validate('a' * 31);
      expect(result, isA<ValidationInvalid>());
      expect(
        (result as ValidationInvalid).message,
        AppStrings.validatorInvalidUsernameLong(30),
      );
    });

    test('returns valid at exactly minimum length (3)', () {
      final result = validator.validate('abc');
      expect(result, isA<ValidationValid>());
    });

    test('returns valid at exactly maximum length (30)', () {
      final result = validator.validate('a' * 30);
      expect(result, isA<ValidationValid>());
    });

    test('returns valid for a normal username', () {
      final result = validator.validate('john_doe');
      expect(result, isA<ValidationValid>());
    });

    test('trims whitespace before checking length', () {
      // "  a  " trims to "a" which is < 3
      final result = validator.validate('  a  ');
      expect(result, isA<ValidationInvalid>());
    });
  });
}
