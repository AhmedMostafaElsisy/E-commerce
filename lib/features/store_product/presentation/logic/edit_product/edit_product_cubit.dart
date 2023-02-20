import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/model/category_model.dart';
import '../../../../../core/model/image_model.dart';
import '../../../domain/ues_cases/product_ues_cases.dart';
import 'edit_product_states.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit(this.uesCase) : super(EditProductInitialState());

  static EditProductCubit get(context) => BlocProvider.of(context);
  final ProductUesCase uesCase;
  List<XFile> imageXFile = [];
  List<TextEditingController> controllerList = [];
  late bool isDataFound;
  late ProductModel selectedProduct;

  photoPicked(XFile xFile) {
    selectedProduct.images!.add(ImageModel(fileImage: xFile.path));
    imageXFile.add(xFile);
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

  ///edit  product
  editProduct({
    required String productName,
    required String productMainPrice,
    required String productDiscountPrice,
    required String productType,
    List<XFile>? productImage,
    required String productStates,
    required String productBrand,
    required String productDescription,
    required String storeId,
    required String productId,
  }) async {
    emit(EditProductLoadingState());
    var result = await uesCase.callEditProduct(
        productName: productName,
        productMainPrice: productMainPrice,
        productDiscountPrice: productDiscountPrice,
        productType: productType,
        productImage: productImage,
        productStates: productStates,
        productBrand: productBrand,
        productDescription: productDescription,
        storeId: storeId,
        shopModel: selectedProduct.shopModel!,
        productId: productId);
    result.fold((failed) => emit(EditProductFailState(failed)),
        (r) => emit(EditProductSuccessState()));
  }
}
