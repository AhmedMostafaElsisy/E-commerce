import '../../../../../core/Error_Handling/custom_error.dart';

abstract class ProductDetailsStates {}

class ProductDetailsInitStates extends ProductDetailsStates {}

class ProductDetailsLoadingStates extends ProductDetailsStates {}

class ProductDetailsFailedStates extends ProductDetailsStates {
  CustomError error;

  ProductDetailsFailedStates({required this.error});
}

class ProductDetailsSuccessStates extends ProductDetailsStates {}
