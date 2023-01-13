import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class AddNewProductLoadingState extends ProductState {}

class AddNewProductSuccessState extends ProductState {}

class AddNewProductErrorState extends ProductState {
  CustomError error;

  AddNewProductErrorState(this.error);
}

class CheckInputValidationState extends ProductInitialState {}

class UploadingUserImageLoadingState extends ProductInitialState {}

class GetProductDetailsLoadingState extends ProductState {}

class GetProductDetailsSuccessState extends ProductState {}

class GetProductDetailsErrorState extends ProductState {
  CustomError error;

  GetProductDetailsErrorState(this.error);
}


class DeleteProductLoadingState extends ProductState {}

class DeleteProductSuccessState extends ProductState {}

class DeleteProductErrorState extends ProductState {
  CustomError error;

  DeleteProductErrorState(this.error);
}