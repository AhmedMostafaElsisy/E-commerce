import 'package:default_repo_app/Constants/Enums/auth_validations_enmu.dart';
import 'package:default_repo_app/Data/Validators/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Grouping of validators',
    () {
      test('email validation', () {
        expect(validateEmail(''), EmailValidationResults.emptyEmail);
        expect(validateEmail('h@1.com'), EmailValidationResults.notValid);
        expect(validateEmail('h@h.com'), EmailValidationResults.valid);
      });

      test('phone validation', () {
        expect(validatePhone(''), PhoneValidationResults.emptyPhone);
        expect(validatePhone('1234567890'), PhoneValidationResults.tooShort);
        expect(validatePhone('1234567890a'), PhoneValidationResults.notMatched);
        expect(validatePhone('12345678901'), PhoneValidationResults.valid);
      });

      test('password validation', () {
        expect(validatePassword(''), PasswordValidationResults.emptyPassword);
        expect(
            validatePassword('pass'), PasswordValidationResults.tooShort);
        expect(validatePassword('password'),
            PasswordValidationResults.valid);
      });
    },
  );
}
