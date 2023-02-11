import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/ues_cases/ues_cases.dart';
import 'edit_my_store_states.dart';

class EditStoreCubit extends Cubit<EditMyStoreState> {
  EditStoreCubit(this.uesCase) : super(EditMyStoreInitialState());

  static EditStoreCubit get(context) => BlocProvider.of(context);
  final StoreUesCase uesCase;

  set _imageFile(XFile? value) {
    imageXFile = value;
  }

  XFile? imageXFile;
  late bool isDataFound;
  late TextEditingController storeNameController;
  late TextEditingController ownerNameController;
  late TextEditingController userAddressController;
  late TextEditingController userCityController;
  late TextEditingController userAreaController;
  late TextEditingController emailAddressController;
  late TextEditingController phoneNumberController;
  late TextEditingController storeMainCategoryController;
  late TextEditingController storeSubCategoryController;
  List<TextEditingController> controllerList = [];

  photoPicked(XFile xFile) {
    _imageFile = xFile;
    emit(EditUploadingUserImageLoadingState());
  }

  void isDataFount(List<TextEditingController> list) {
    isDataFound = true;
    emit(CheckInputValidationState());

    for (var element in list) {
      if (element.text.isEmpty) {
        isDataFound = false;
        return;
      }
    }
    emit(CheckInputValidationState());
  }

  ///edit store
  editStore({
    required int storeId,
    XFile? storeImage,
  }) async {
    emit(EditStoreLoadingStates());
    var result = await uesCase.editStore(
        storeId: storeId,
        storeImage: imageXFile,
        storeName:  storeNameController
            .text,
        ownerName: ownerNameController
            .text,
        storeNumber: phoneNumberController
            .text,
        storeEmail: emailAddressController
            .text,
        storeAddress:userAddressController
            .text,
        storeCity:userCityController
            .text,
        storeArea: userAreaController
            .text,
        storeMainCategory:storeMainCategoryController
            .text,
        storeSubCategory:storeSubCategoryController
            .text,);
    result.fold((error) => emit(EditStoreFailedStates(error)),
        (success) => emit(EditStoreSuccessStates()));
  }
}
