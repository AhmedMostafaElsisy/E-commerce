import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/location_feature/domain/model/location_area_model.dart';
import '../../../../../core/model/category_model.dart';
import '../../../../../core/model/shop_model.dart';
import '../../../../../core/tags_feature/domain/model/tags_model.dart';
import '../../../domain/ues_cases/ues_cases.dart';
import 'store_states.dart';

class StoreCubit extends Cubit<StoreStates> {
  StoreCubit(this.uesCase) : super(StoreInitialStates());

  static StoreCubit get(context) => BlocProvider.of(context);
  final StoreUesCase uesCase;

  List<ShopModel> myStoreList = [];
  List<TextEditingController> controllerList = [];
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

  set _imageFile(XFile? value) {
    imageXFile = value;
  }

  XFile? imageXFile;

  photoPicked(XFile xFile) {
    _imageFile = xFile;
    emit(UploadingUserImageLoadingState());
  }

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  bool hasMoreData = false;
  LocationAreaModel? selectedCity;
  LocationAreaModel? selectedArea;
  CategoryModel? selectedCategory;
  List<TagsModel>? selectedTag;

  setNewCitySelected(LocationAreaModel model) {
    selectedCity = model;
    selectedArea = null;
    emit(LocationSelectedState());
  }

  setSelectedArea(LocationAreaModel model) {
    selectedArea = model;
    emit(LocationSelectedState());
  }

  setSelectedCategory(CategoryModel model) {
    selectedCategory = model;
    emit(LocationSelectedState());
  }

  setSelectedTags(List<TagsModel> model) {
    selectedTag = model;
    emit(LocationSelectedState());
  }

  clearAllData() {
    selectedArea = null;
    selectedCity = null;
    selectedCategory = null;
    selectedTag = null;
    emit(LocationSelectedState());
  }

  getMyStoreListData() async {
    emit(StoreLoadingStates());
    page = 1;
    var result = await uesCase.getMyShopList(page: page);
    result.fold((error) => emit(StoreFailedStates(error)), (data) {
      myStoreList = data;
      if (myStoreList.isEmpty) {
        emit(StoreEmptyStates());
      } else {
        emit(StoreSuccessStates());
      }
    });
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! StoreLoadingMoreDataStates && hasMoreData) {
        whenScrollMyStorePagination();
      }
    }
  }

  ///get request history pagination
  whenScrollMyStorePagination() async {
    emit(StoreLoadingMoreDataStates());
    page = page + 1;
    var result = await uesCase.getMyShopList(page: page);

    result.fold(
      (error) => emit(StoreFailedMoreDataStates(error)),
      (data) {
        hasMoreData = data.length == 10;
        myStoreList.addAll(data);
        emit(StoreSuccessStates());
      },
    );
  }

  ///create store
  createNewStore({int? planId}) async {
    emit(CreateStoreLoadingStates());
    var result = await uesCase.createNewStore(
        storeImage: imageXFile!,
        storeName: storeNameController.text,
        ownerName: ownerNameController.text,
        storeNumber: phoneNumberController.text,
        storeEmail: emailAddressController.text,
        storeAddress: userAddressController.text,
        storeCity: selectedCity!.id.toString(),
        storeArea: selectedArea!.id.toString(),
        storeMainCategory: selectedCategory!.id.toString(),
        storeSubCategory: selectedTag!,
        planId: planId);
    result.fold((error) => emit(CreateStoreFailedStates(error)),
        (success) => emit(CreateStoreSuccessStates()));
  }
}
