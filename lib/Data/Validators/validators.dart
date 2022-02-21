import 'enums.dart';

final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+");

final RegExp email2RegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

final RegExp phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{11}$)');

final RegExp emailStartsSpecial = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

RegExp myRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9]");

/// Email Validation
String? emailValidator(String email) {
  if (email.isEmpty) {
    return 'Please enter an email';
  } else if (!emailRegExp.hasMatch(email)) {
    return 'Please enter a valid email';
  } else {
    return null;
  }
}

/// Phone Number Validation
String? phoneValidator(String phoneNumber) {
  if (phoneNumber.isEmpty) {
    return 'Please enter mobile number';
  } else if (!phoneRegExp.hasMatch(phoneNumber)) {
    return 'Please enter a valid mobile number';
  } else {
    return null;
  }
}

/// Phone Validation
PhoneValidationResults validatePhone(String phone) {
  if (phone.isEmpty) {
    return PhoneValidationResults.emptyPhone;
  }
  if (phone.length < 11) {
    return PhoneValidationResults.tooShort;
  }
  if (!phoneRegExp.hasMatch(phone)) {
    return PhoneValidationResults.notMatched;
  }
  return PhoneValidationResults.valid;
}

/// Email Validation
EmailValidationResults validateEmail(String email) {
  if (email.isEmpty) {
    return EmailValidationResults.emptyEmail;
  }
  if (!emailRegExp.hasMatch(email)) {
    return EmailValidationResults.notValid;
  }
  if (!email.startsWith(myRegExp, 0)) {
    return EmailValidationResults.emailStartWith;
  }
  return EmailValidationResults.valid;
}

/// Password Validation
PasswordValidationResults validatePassword(String password) {
  if (password.isEmpty) {
    return PasswordValidationResults.emptyPassword;
  }
  if (password.length < 6) {
    return PasswordValidationResults.tooShort;
  }
  return PasswordValidationResults.valid;
}
