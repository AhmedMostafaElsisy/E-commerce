import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

abstract class ProductListStates {}

class ProductListInitStates extends ProductListStates {}

class ProductListLoadingStates extends ProductListStates {}

class ProductListFailedStates extends ProductListStates {
  CustomError error;

  ProductListFailedStates({required this.error});
}

class ProductListEmptyStates extends ProductListStates {}

class ProductListSuccessStates extends ProductListStates {}

class GetMoreProductListLoadingStates extends ProductListStates {}

class GetMoreProductListFailedStates extends ProductListStates {
  CustomError error;

  GetMoreProductListFailedStates({required this.error});
}

class GetMoreProductListSuccessStates extends ProductListStates {}
