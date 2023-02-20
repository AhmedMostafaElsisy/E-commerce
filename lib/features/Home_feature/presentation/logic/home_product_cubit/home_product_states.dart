import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

abstract class HomeProductStates {}

class HomeProductInitStates extends HomeProductStates {}

class HomeProductLoadingStates extends HomeProductStates {}

class HomeProductFailedStates extends HomeProductStates {
  CustomError error;

  HomeProductFailedStates({required this.error});
}

class HomeProductSuccessStates extends HomeProductStates {}
