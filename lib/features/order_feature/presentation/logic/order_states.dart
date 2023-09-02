import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

abstract class OrderStates {}

class OrderInitialStates extends OrderStates {}

class OrderLoadingStates extends OrderStates {}

class OrderEmptyStates extends OrderStates {}

class OrderSuccessStates extends OrderStates {}

class OrderFailedStates extends OrderStates {
  CustomError error;

  OrderFailedStates(this.error);
}

class OrderLoadingMoreDataStates extends OrderStates {}

class OrderFailedMoreDataStates extends OrderStates {
  CustomError error;

  OrderFailedMoreDataStates(this.error);
}

