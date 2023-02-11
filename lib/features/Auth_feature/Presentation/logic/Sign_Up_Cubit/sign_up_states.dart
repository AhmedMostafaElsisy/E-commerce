import '../../../../../core/model/base_model.dart';
import '../../../../../core/Error_Handling/custom_error.dart';

abstract class SignUpStates {}

class SignUpStatesInit extends SignUpStates {}

/// Show Loader
class SignUpLoading extends SignUpStates {}

/// Go To HomePage with User Data
class SignUpSuccess extends SignUpStates {
  BaseModel user;

  SignUpSuccess(this.user);
}

/// Show loader for user login
class UserSignUpLoadingState extends SignUpStates {}

/// Go to home after success
class UserSignUpSuccessState extends SignUpStates {
  String otp;

  UserSignUpSuccessState(this.otp);
}

/// Show loader for user login
class UserSignUpCredentialsNotValidState extends SignUpStates {
  String? massage;

  UserSignUpCredentialsNotValidState({this.massage});
}

/// Show failed login for user
class UserSignUpErrorState extends SignUpStates {
  CustomError? error;

  UserSignUpErrorState({
    this.error,
  });
}

class UploadingUserImageLoadingState extends SignUpStates {}

class ShowOrHidePasswordState extends SignUpStates {}

class CheckInputValidationState extends SignUpStates {}
class LocationSelectedState extends SignUpStates {}
