import 'package:captien_omda_customer/core/location_feature/domain/model/location_area_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/model/category_model.dart';
import '../../../../../core/tags_feature/domain/model/tags_model.dart';
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

  LocationAreaModel? selectedCity;
  LocationAreaModel? selectedArea;
  CategoryModel? selectedCategory;
  List<TagsModel>? selectedTag;

  setNewCitySelected(LocationAreaModel model) {
    selectedCity = model;
    selectedArea = null;
    emit(CheckInputValidationState());
  }

  setSelectedArea(LocationAreaModel model) {
    selectedArea = model;
    emit(CheckInputValidationState());
  }

  setSelectedCategory(CategoryModel model) {
    selectedCategory = model;
    emit(CheckInputValidationState());
  }

  setSelectedTags(List<TagsModel> model) {
    selectedTag = model;
    emit(CheckInputValidationState());
  }
  photoPicked(XFile xFile) {
    _imageFile = xFile;
    emit(EditUploadingUserImageLoadingState());
  }
  clearAllData() {
    selectedArea = null;
    selectedCity = null;
    selectedCategory = null;
    selectedTag = null;
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
    required int planId,
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
      storeCity: selectedCity!.id.toString(),
      storeArea: selectedArea!.id.toString(),
      storeMainCategory: selectedCategory!.id.toString(),
      storeSubCategory: selectedTag!,
      planId: planId

    );
    result.fold((error) => emit(EditStoreFailedStates(error)),
        (success) => emit(EditStoreSuccessStates()));
  }

}
