import 'package:flutter_test/flutter_test.dart';
import 'package:lanars_test_task/core/helpers/validator.dart';

void main() {
  group('Validator.validateUserEmail', () {
    test('returns error if email is null', () {
      expect(Validator.validateUserEmail(null), 'Email is required.');
    });

    test('returns error if email is empty', () {
      expect(Validator.validateUserEmail(''), 'Email is required.');
    });

    test('returns error if email is too short', () {
      expect(Validator.validateUserEmail('a@b.c'),
          'Email should be between 6 and 30 characters.');
    });

    test('returns error if email is too long', () {
      expect(
        Validator.validateUserEmail('verylongemailaddress@exampledomain.com'),
        'Email should be between 6 and 30 characters.',
      );
    });

    test('returns error if email format is incorrect', () {
      expect(Validator.validateUserEmail('invalidemail@com'),
          'Email is incorrect.');
      expect(
          Validator.validateUserEmail('invalid@.com'), 'Email is incorrect.');
      expect(
          Validator.validateUserEmail('invalid@com.'), 'Email is incorrect.');
    });

    test('returns null for valid email', () {
      expect(Validator.validateUserEmail('test@example.com'), null);
      expect(Validator.validateUserEmail('user.name@domain.co'), null);
    });
  });

  group('Validator.validatePassword', () {
    test('returns error if password is null', () {
      expect(Validator.validatePassword(null), 'Password is required.');
    });

    test('returns error if password is empty', () {
      expect(Validator.validatePassword(''), 'Password is required.');
    });

    test('returns error if password is too short', () {
      expect(Validator.validatePassword('Ab1'),
          'Password should be between 6 and 10 characters.');
    });

    test('returns error if password is too long', () {
      expect(Validator.validatePassword('Abcdefg1234'),
          'Password should be between 6 and 10 characters.');
    });

    test('returns error if password has no uppercase letter', () {
      expect(Validator.validatePassword('abcdef1'),
          'Password must contain at least one uppercase letter.');
    });

    test('returns error if password has no lowercase letter', () {
      expect(Validator.validatePassword('ABCDEF1'),
          'Password must contain at least one lowercase letter.');
    });

    test('returns error if password has no digit', () {
      expect(Validator.validatePassword('Abcdefg'),
          'Password must contain at least one digit.');
    });

    test('returns null for valid password', () {
      expect(Validator.validatePassword('Abc123'), null);
      expect(Validator.validatePassword('Xyz789'), null);
    });
  });
}
