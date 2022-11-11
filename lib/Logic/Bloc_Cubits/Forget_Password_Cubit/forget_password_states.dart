import '../../../Data/Remote_Data/Network/Dio_Exception_Handling/custom_error.dart';

abstract class ForgetPasswordStates {}

class ForgetPasswordStatesInit extends ForgetPasswordStates {}

class ForgetPasswordLoadingState extends ForgetPasswordStates {}

class ForgetPasswordForgetSuccessState extends ForgetPasswordStates {}

class ForgetPasswordSuccessState extends ForgetPasswordStates {}

class ForgetPasswordErrorState extends ForgetPasswordStates {
  CustomError? error;

  ForgetPasswordErrorState({this.error});
}

/// Send Verification Code To Email
class SendVerificationToEmailStateLoading extends ForgetPasswordStates {}

class SendVerificationToEmailStateError extends ForgetPasswordStates {
  CustomError? error;

  SendVerificationToEmailStateError({this.error});
}

class SendVerificationToEmailStateSuccess extends ForgetPasswordStates {

}

/// Change Password
class ChangePasswordStateLoading extends ForgetPasswordStates {}

class ChangePasswordStateError extends ForgetPasswordStates {
  CustomError? error;

  ChangePasswordStateError({this.error});
}

class ChangePasswordStateSuccess extends ForgetPasswordStates {}
