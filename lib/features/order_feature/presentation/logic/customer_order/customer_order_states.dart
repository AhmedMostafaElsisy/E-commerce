import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

abstract class CustomerOrderStates {}

class CustomerInitialStates extends CustomerOrderStates {}

class CustomerLoadingStates extends CustomerOrderStates {}

class CustomerEmptyStates extends CustomerOrderStates {}

class CustomerSuccessStates extends CustomerOrderStates {}

class CustomerFailedStates extends CustomerOrderStates {
  CustomError error;

  CustomerFailedStates(this.error);
}

class CustomerLoadingMoreDataStates extends CustomerOrderStates {}

class CustomerFailedMoreDataStates extends CustomerOrderStates {
  CustomError error;

  CustomerFailedMoreDataStates(this.error);
}

