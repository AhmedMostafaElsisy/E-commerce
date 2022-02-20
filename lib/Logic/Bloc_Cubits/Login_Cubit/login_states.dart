import 'package:default_repo_app/Data/Dio_Exception_Handling/custom_error.dart';
import 'package:default_repo_app/Logic/Models/user_base_model.dart';

abstract class LoginStates {}

class LoginStatesInit extends LoginStates {}

/// Show Loader
class LoginIfFoundLoading extends LoginStates {}

/// Go To HomePage with User Data
class LoginSuccess extends LoginStates {
  UserBaseModel user;

  LoginSuccess(this.user);
}

/// Go To HomePage Without User Data
class LoginFailed extends LoginStates {}

/// show loader for user login
class UserLoginLoadingState extends LoginStates {}

/// go to home after success
class UserLogInSuccessState extends LoginStates {
  UserBaseModel user;

  UserLogInSuccessState(this.user);
}

class UserLogoutSuccessState extends LoginStates {
  UserLogoutSuccessState();
}

class LoginUnVerifiedState extends LoginStates {
  String? userPhone;

  LoginUnVerifiedState({this.userPhone});
}

/// show failed login for user
class UserLoginErrorState extends LoginStates {
  CustomError? error;

  UserLoginErrorState({this.error});
}
