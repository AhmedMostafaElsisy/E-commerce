import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

abstract class FilterStates {}

class FilterInitStates extends FilterStates {}

class FilterLoadingStates extends FilterStates {}

class FilterFailedStates extends FilterStates {
  CustomError error;

  FilterFailedStates({required this.error});
}

class FilterUpdateDataStates extends FilterStates {}

class FilterSuccessStates extends FilterStates {}
