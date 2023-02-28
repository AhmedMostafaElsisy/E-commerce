import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

abstract class EditProductState {}

class EditProductInitialState extends EditProductState {}

class CheckInputValidationState extends EditProductState {}
class UploadingUserImageLoadingState extends EditProductState {}

class EditProductLoadingState extends EditProductState {}

class EditProductSuccessState extends EditProductState {}

class EditProductFailState extends EditProductState {
  CustomError error;

  EditProductFailState(this.error);
}
class GetEditProductDetailsEditLoadingState extends EditProductState {}

class GetEditProductDetailsEditSuccessState extends EditProductState {}

class GetEditProductDetailsEditFailedState extends EditProductState {
  CustomError error;

  GetEditProductDetailsEditFailedState(this.error);
}
