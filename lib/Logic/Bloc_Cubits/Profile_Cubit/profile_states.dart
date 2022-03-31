import 'package:default_repo_app/Data/Network/Dio_Exception_Handling/custom_error.dart';
import 'package:default_repo_app/Data/Models/user_base_model.dart';

abstract class ProfileCubitStates {}

class ProfileStatesInit extends ProfileCubitStates {}

/// show loader for user Profile_Cubit
class ProfileLoadingState extends ProfileCubitStates {}

/// show loader for user Profile_Cubit
class ProfileUpdateSuccessState extends ProfileCubitStates {
  String? massage;

  ProfileUpdateSuccessState({this.massage});
}

class ProfileSuccessState extends ProfileCubitStates {
  UserBaseModel user;

  ProfileSuccessState(this.user);
}

class ChangePasswordNotMatchState extends ProfileCubitStates {}

/// show failed OTP_Cubit for user
class ProfileErrorState extends ProfileCubitStates {
  CustomError? error;

  ProfileErrorState({
    this.error,
  });
}
