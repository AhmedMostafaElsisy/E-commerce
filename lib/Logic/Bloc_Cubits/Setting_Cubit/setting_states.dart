


import '../../../Data/Models/faq_model.dart';
import '../../../Data/Models/terms_model.dart';
import '../../../core/Error_Handling/custom_error.dart';

abstract class SettingCubitStates {}

class SettingCubitStatesInit extends SettingCubitStates {}

class SettingCubitLoadingState extends SettingCubitStates {}

class SettingCubitTermsSuccessState extends SettingCubitStates {
  TermsModel? model;

  SettingCubitTermsSuccessState({this.model});
}

class SettingCubitFqaSuccessState extends SettingCubitStates {
  List<FqaModel>? fqaList;

  SettingCubitFqaSuccessState({this.fqaList});
}

class SettingCubitErrorState extends SettingCubitStates {
  CustomError? error;

  SettingCubitErrorState({this.error});
}
