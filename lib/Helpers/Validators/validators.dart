import 'package:default_repo_app/Constants/Enums/auth_validations_enmu.dart';


final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+");

final RegExp email2RegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

final RegExp phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{11}$)');

final RegExp emailStartsSpecial = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

RegExp myRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9]");

/// Email Validation
bool emailValidator(String email) {
  if (email.isEmpty) {
    return  false;
  } else if (!emailRegExp.hasMatch(email)) {
    return false;
  } else {
    return true;
  }
}

/// Phone Number Validation
bool phoneValidator(String phoneNumber) {
  if (phoneNumber.isEmpty) {
    return false;
  } else if (!phoneRegExp.hasMatch(phoneNumber)) {
    return false;
  } else {
    return true;
  }
}

/// Phone Validation
bool validatePhone(String phone) {
  if (phone.isEmpty) {
    return false;
  }
  if (phone.length < 11) {
    return false;
  }
  if (!phoneRegExp.hasMatch(phone)) {
    return false;
  }
  return true;
}

/// Email Validation
bool validateEmail(String email) {
  if (email.isEmpty) {
    return false;
  }
  if (!emailRegExp.hasMatch(email)) {
    return false;
  }
  if (!email.startsWith(myRegExp, 0)) {
    return false;
  }
  return true;
}

/// Password Validation
bool validatePassword(String password) {
  if (password.isEmpty) {
    return false;
  }
  if (password.length < 6) {
    return false;
  }
  return true;
}
