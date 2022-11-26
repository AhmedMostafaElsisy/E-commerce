import 'package:default_repo_app/core/Error_Handling/custom_error.dart';
import 'package:default_repo_app/Data/Models/faq_model.dart';
import 'package:default_repo_app/Data/Models/terms_model.dart';


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
