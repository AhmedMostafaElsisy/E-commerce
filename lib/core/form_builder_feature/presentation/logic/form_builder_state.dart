import '../../../Error_Handling/custom_error.dart';

abstract class FormBuilderState {}

class FormBuilderProductInitialState extends FormBuilderState {}

class GetCategoryFormLoadingStates extends FormBuilderState {}

class GetCategoryFormSuccessStates extends FormBuilderState {}

class GetCategoryFormErrorStates extends FormBuilderState {
  CustomError error;

  GetCategoryFormErrorStates(this.error);
}
