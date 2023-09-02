import '../../../../../core/Error_Handling/custom_error.dart';

abstract class MyStoreStates {}

class MyStoreInitialStates extends MyStoreStates {}

class MyStoreLoadingStates extends MyStoreStates {}

class MyStoreEmptySuccessStates extends MyStoreStates {}
class MyStoreSuccessStates extends MyStoreStates {}

class MyStoreFailedStates extends MyStoreStates {
  CustomError error;

  MyStoreFailedStates(this.error);
}

class MyStoreLoadingMoreDataStates extends MyStoreStates {}
class MyStoreFailedLoadingMoreStates extends MyStoreStates {
  CustomError error;

  MyStoreFailedLoadingMoreStates(this.error);
}