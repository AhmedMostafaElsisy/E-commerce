import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

abstract class SettingCubitState {}

class SettingInitialState extends SettingCubitState {}

class SettingLoadingState extends SettingCubitState {}

class SettingSuccessState extends SettingCubitState {

}

class SettingFailedState extends SettingCubitState {
  CustomError error;

  SettingFailedState(this.error);
}
