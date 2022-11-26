import 'package:default_repo_app/core/Error_Handling/custom_error.dart';
import 'package:default_repo_app/features/Auth_feature/Domain/entities/base_user_entity.dart';

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
  UserBaseEntity user;

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
