import '../../../core/Error_Handling/custom_error.dart';

abstract class HelpStates {}

class HelpStatesInit extends HelpStates {}

class HelpLoadingState extends HelpStates {}

class HelpSuccessState extends HelpStates {
  String? massage;

  HelpSuccessState({this.massage});
}

class HelpErrorState extends HelpStates {
  CustomError? error;

  HelpErrorState({this.error});
}
