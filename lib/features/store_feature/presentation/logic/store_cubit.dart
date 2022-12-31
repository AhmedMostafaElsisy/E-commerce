import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/model/shop_model.dart';
import '../../domain/ues_cases/ues_cases.dart';
import 'store_states.dart';

class StoreCubit extends Cubit<StoreStates> {
  StoreCubit(this.uesCase) : super(StoreInitialStates());

  static StoreCubit get(context) => BlocProvider.of(context);
  final StoreUesCase uesCase;

  List<ShopModel> myStoreList = [];
  List<TextEditingController> controllerList = [];
  late bool isDataFound;

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
  createNewStore({
    required XFile storeImage,
    required String storeName,
    required String ownerName,
    required String storeNumber,
    required String storeEmail,
    required String storeAddress,
    required String storeCity,
    required String storeArea,
    required String storeMainCategory,
    required String storeSubCategory,
  }) async {
    emit(CreateStoreLoadingStates());
    var result = await uesCase.createNewStore(
        storeImage: storeImage,
        storeName: storeName,
        ownerName: ownerName,
        storeNumber: storeNumber,
        storeEmail: storeEmail,
        storeAddress: storeAddress,
        storeCity: storeCity,
        storeArea: storeArea,
        storeMainCategory: storeMainCategory,
        storeSubCategory: storeSubCategory);
    result.fold((error) => emit(CreateStoreFailedStates(error)),
        (success) => emit(CreateStoreSuccessStates()));
  }
}
