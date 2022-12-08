
import '../../../../../core/Error_Handling/custom_error.dart';
import '../../../Domain/entities/base_user_entity.dart';

abstract class LoginStates {}

class LoginStatesInit extends LoginStates {}

/// Show Loader
class LoginIfFoundLoading extends LoginStates {}

/// Go To HomePage with User Data
class LoginSuccess extends LoginStates {
  UserBaseEntity user;

  LoginSuccess(this.user);
}

/// Go To HomePage Without User Data
class LoginFailed extends LoginStates {}

/// show loader for user login
class UserLoginLoadingState extends LoginStates {}

/// go to home after success
class UserLogInSuccessState extends LoginStates {
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
