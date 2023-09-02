import '../../../../../core/Error_Handling/custom_error.dart';

abstract class EditMyStoreState {}

class EditMyStoreInitialState extends EditMyStoreState {}

class EditUploadingUserImageLoadingState extends EditMyStoreState {}
class CheckInputValidationState extends EditMyStoreState {}

class EditStoreLoadingStates extends EditMyStoreState {}

class EditStoreFailedStates extends EditMyStoreState {
  CustomError error;

  EditStoreFailedStates(this.error);
}

class EditStoreSuccessStates extends EditMyStoreState {}
