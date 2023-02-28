import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/model/category_model.dart';
import '../../../../../core/model/image_model.dart';
import '../../../domain/ues_cases/edit_product_ues_cases.dart';
import 'edit_product_states.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit(this.uesCase) : super(EditProductInitialState());

  static EditProductCubit get(context) => BlocProvider.of(context);
  final EditProductUesCase uesCase;
  List<TextEditingController> controllerList = [];
  late bool isDataFound;
  late ProductModel selectedProduct;

  late TextEditingController adsDetailsController;
  late TextEditingController adsMainPriceController;
  late TextEditingController adsDiscountPriceController;
  late TextEditingController adsNameController;

  late TextEditingController adsTypeController;
  late TextEditingController adsStatesController;
  late TextEditingController adsBrandController;
  List<String> deletedImage = [];

  photoPicked(XFile xFile) {
    selectedProduct.images!.add(ImageModel(fileImage: xFile.path));
    emit(UploadingUserImageLoadingState());
  }
  ///delete photo
  deletePhoto(int itemPosition) {
    if(selectedProduct.images![itemPosition].id !=null) {
      deletedImage.add(selectedProduct.images![itemPosition].id!.toString());
    }
    selectedProduct.images!.removeAt(itemPosition);

    emit(UploadingUserImageLoadingState());
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

  CategoryModel? selectedCategory;

  setSelectedCategory(CategoryModel model) {
    selectedCategory = model;
    emit(CheckInputValidationState());
  }

  ///get My ads details on edit
  getMyAdsEditDetails(int productId) async {
    emit(GetEditProductDetailsEditLoadingState());
    var result = await uesCase.callGetProductDetailsEdit(productId: productId);
    result.fold((error) => emit(GetEditProductDetailsEditFailedState(error)),
        (postListData) {
      selectedProduct = postListData;
      deletedImage = [];
      adsNameController = TextEditingController(text: selectedProduct.name);
      adsDetailsController =
          TextEditingController(text: selectedProduct.description!);
      adsMainPriceController =
          TextEditingController(text: selectedProduct.price.toString());
      adsDiscountPriceController =
          TextEditingController(text: selectedProduct.discount.toString());
      adsTypeController = TextEditingController(text: selectedProduct.type!);
      adsStatesController = TextEditingController(text: selectedProduct.state!);
      adsBrandController =
          TextEditingController(text: selectedProduct.categoryModel!.name);
      controllerList.add(adsNameController);
      controllerList.add(adsDetailsController);
      controllerList.add(adsMainPriceController);
      controllerList.add(adsDiscountPriceController);
      controllerList.add(adsTypeController);
      controllerList.add(adsStatesController);
      controllerList.add(adsBrandController);
      isDataFount(controllerList);
      selectedCategory = selectedProduct.categoryModel!;
      emit(GetEditProductDetailsEditSuccessState());
    });
  }

  ///edit  product
  editProduct() async {
    emit(EditProductLoadingState());
    var result = await uesCase.callEditProduct(
        productName: adsNameController.text,
        productMainPrice: adsMainPriceController.text,
        productDiscountPrice: adsDiscountPriceController.text,
        productType: adsTypeController.text,
        productImage: selectedProduct.images,
        productStates: adsStatesController.text,
        productBrand: selectedCategory!.id.toString(),
        productDescription: adsDetailsController.text,
        storeId: selectedProduct.shopModel!.id.toString(),
        shopModel: selectedProduct.shopModel!,
        productId: selectedProduct.id!.toString(),
    formData: selectedProduct.formList!,
      productImageDeleted:deletedImage
    );
    result.fold((failed) => emit(EditProductFailState(failed)),
        (r) => emit(EditProductSuccessState()));
  }
}
