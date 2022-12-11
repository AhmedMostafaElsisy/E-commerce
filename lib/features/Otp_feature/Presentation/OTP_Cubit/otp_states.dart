
import '../../../../core/Error_Handling/custom_error.dart';

abstract class OtpStates {}

class OtpStatesInit extends OtpStates {}

/// show loader for user login
class OtpLoadingState extends OtpStates {}

class OtpForgetSuccessState extends OtpStates {}

/// go to home after success
class OtpSuccessState extends OtpStates {

  OtpSuccessState();
}

/// show failed OTP_Cubit for user
class OtpErrorState extends OtpStates {
  CustomError? error;

  OtpErrorState({
    this.error,
  });
}
/// show loader for user login
class ResendOtpLoadingState extends OtpStates {}

class ResendOtpForgetSuccessState extends OtpStates {}

/// go to home after success
class ResendOtpSuccessState extends OtpStates {}

