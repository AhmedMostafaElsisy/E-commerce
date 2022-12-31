import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

abstract class StoreStates {}

class StoreInitialStates extends StoreStates {}

class StoreLoadingStates extends StoreStates {}

class StoreEmptyStates extends StoreStates {}

class StoreSuccessStates extends StoreStates {}

class StoreFailedStates extends StoreStates {
  CustomError error;

  StoreFailedStates(this.error);
}

class UploadingUserImageLoadingState extends StoreStates {}
class CheckInputValidationState extends StoreStates {}
class StoreLoadingMoreDataStates extends StoreStates {}

class StoreFailedMoreDataStates extends StoreStates {
  CustomError error;

  StoreFailedMoreDataStates(this.error);
}


class CreateStoreLoadingStates extends StoreStates {}


class CreateStoreSuccessStates extends StoreStates {}

class CreateStoreFailedStates extends StoreStates {
  CustomError error;

  CreateStoreFailedStates(this.error);
}