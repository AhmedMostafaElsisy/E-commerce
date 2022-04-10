import 'package:default_repo_app/Data/Models/user_base_model.dart';
import 'package:default_repo_app/Data/Remote_Data/Network/Dio_Exception_Handling/custom_error.dart';

abstract class SignUpStates {}

class SignUpStatesInit extends SignUpStates {}

/// Show Loader
class SignUpLoading extends SignUpStates {}

/// Go To HomePage with User Data
class SignUpSuccess extends SignUpStates {
  UserBaseModel user;

  SignUpSuccess(this.user);
}

/// Show loader for user login
class UserSignUpLoadingState extends SignUpStates {}

/// Go to home after success
class UserSignUpSuccessState extends SignUpStates {
  UserBaseModel user;

  UserSignUpSuccessState(this.user);
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
