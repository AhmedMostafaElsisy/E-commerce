import '../../../../../core/Error_Handling/custom_error.dart';

abstract class PasswordStates {}

class ForgetPasswordStatesInit extends PasswordStates {}

class ForgetPasswordLoadingState extends PasswordStates {}

class ForgetPasswordForgetSuccessState extends PasswordStates {}

class ForgetPasswordSuccessState extends PasswordStates {}

class ForgetPasswordErrorState extends PasswordStates {
  CustomError? error;

  ForgetPasswordErrorState({this.error});
}

/// Send Verification Code To Email
class SendVerificationToEmailStateLoading extends PasswordStates {}

class SendVerificationToEmailStateError extends PasswordStates {
  CustomError? error;

  SendVerificationToEmailStateError({this.error});
}

class SendVerificationToEmailStateSuccess extends PasswordStates {
  String code;

  SendVerificationToEmailStateSuccess(this.code);
}

/// Change Password
class ChangePasswordStateLoading extends PasswordStates {}

class ChangePasswordStateError extends PasswordStates {
  CustomError? error;

  ChangePasswordStateError({this.error});
}

class ChangePasswordStateSuccess extends PasswordStates {}
