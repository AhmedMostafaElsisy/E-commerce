import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

abstract class GeneralStoresStates {}

class GeneralStoresInitialStates extends GeneralStoresStates {}

class GeneralStoresLoadingStates extends GeneralStoresStates {}

class GeneralStoresEmptyStates extends GeneralStoresStates {}

class GeneralStoresSuccessStates extends GeneralStoresStates {}

class GeneralStoresFailedStates extends GeneralStoresStates {
  CustomError error;

  GeneralStoresFailedStates(this.error);
}

class GeneralStoresLoadingMoreDataStates extends GeneralStoresStates {}

class GeneralStoresFailedMoreDataStates extends GeneralStoresStates {
  CustomError error;

  GeneralStoresFailedMoreDataStates(this.error);
}
