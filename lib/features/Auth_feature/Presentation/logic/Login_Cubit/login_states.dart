import 'package:captien_omda_customer/features/Auth_feature/Data/model/base_user_model.dart';

import '../../../../../core/Error_Handling/custom_error.dart';

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
class UserLogInSuccessState extends LoginStates {}

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

class UserDeleteAccountLoadingState extends LoginStates {}


