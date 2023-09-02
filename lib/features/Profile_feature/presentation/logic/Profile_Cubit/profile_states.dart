import '../../../../../core/Error_Handling/custom_error.dart';

abstract class ProfileCubitStates {}

class ProfileStatesInit extends ProfileCubitStates {}

/// show loader for user Profile_Cubit
class ProfileLoadingState extends ProfileCubitStates {}

class ProfileSuccessState extends ProfileCubitStates {}

/// show failed for user
class ProfileErrorState extends ProfileCubitStates {
  CustomError? error;

  ProfileErrorState({
    this.error,
  });
}

class ProfileAreaSelectedState extends ProfileCubitStates {}
class UploadingUserImageLoadingState extends ProfileCubitStates {}
class CheckInputValidationState extends ProfileCubitStates {}

/// show loader for user Profile_Cubit
class ProfileUpdateLoadingState extends ProfileCubitStates {}

class ProfileUpdateSuccessState extends ProfileCubitStates {}

class ProfileUpdateFailedState extends ProfileCubitStates {
  CustomError error;

  ProfileUpdateFailedState(this.error);
}
