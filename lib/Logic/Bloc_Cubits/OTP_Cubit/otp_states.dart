import 'package:default_repo_app/Data/Remote_Data/Network/Dio_Exception_Handling/custom_error.dart';
import 'package:default_repo_app/Data/Models/user_base_model.dart';

abstract class OtpStates {}

class OtpStatesInit extends OtpStates {}

/// show loader for user login
class OtpLoadingState extends OtpStates {}

class OtpForgetSuccessState extends OtpStates {}

/// go to home after success
class OtpSuccessState extends OtpStates {
  UserBaseModel user;

  OtpSuccessState(this.user);
}

/// show failed OTP_Cubit for user
class OtpErrorState extends OtpStates {
  CustomError? error;

  OtpErrorState({
    this.error,
  });
}
