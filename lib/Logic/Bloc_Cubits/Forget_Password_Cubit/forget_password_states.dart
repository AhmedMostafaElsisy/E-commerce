import 'package:default_repo_app/Data/Network/Dio_Exception_Handling/custom_error.dart';

abstract class ForgetPasswordStates {}

class ForgetPasswordStatesInit extends ForgetPasswordStates {}

class ForgetPasswordLoadingState extends ForgetPasswordStates {}

class ForgetPasswordForgetSuccessState extends ForgetPasswordStates {}

class ForgetPasswordSuccessState extends ForgetPasswordStates {}

class ForgetPasswordErrorState extends ForgetPasswordStates {
  CustomError? error;

  ForgetPasswordErrorState({this.error});
}
