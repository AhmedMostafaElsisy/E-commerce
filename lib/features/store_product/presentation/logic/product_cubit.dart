import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:captien_omda_customer/features/store_product/presentation/logic/product_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/form_builder_feature/domain/model/form_builder_model.dart';
import '../../../../core/model/category_model.dart';
import '../../../../core/model/shop_model.dart';
import '../../domain/ues_cases/product_ues_cases.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.uesCase) : super(ProductInitialState());

  static ProductCubit get(context) => BlocProvider.of(context);
  final ProductUesCase uesCase;

  List<XFile> imageXFile = [];
  List<TextEditingController> controllerList = [];
  late bool isDataFound;
  late ProductModel productModel;

  photoPicked(XFile xFile) {
    emit(UploadingUserImageLoadingState());

    imageXFile.add(xFile);
    emit(UploadingUserImageSuccessState());
  }

  deletePhoto(int index) {
    emit(UploadingUserImageLoadingState());

    imageXFile.removeAt(index);
    emit(UploadingUserImageSuccessState());
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

  ///add new product
  addNewProduct(
      {required String productName,
      required String productMainPrice,
      required String productDiscountPrice,
      required String productType,
      required List<XFile> productImage,
      required String productStates,
      required String productBrand,
      required String productDescription,
      required List<FormBuilderModel> formData,
      required ShopModel shopModel}) async {
    emit(AddNewProductLoadingState());
    var result = await uesCase.callCreateNewProduct(
        productName: productName,
        productMainPrice: productMainPrice,
        productDiscountPrice: productDiscountPrice,
        productType: productType,
        productImage: productImage,
        productStates: productStates,
        productBrand: productBrand,
        formData: formData,
        productDescription: productDescription,
        shopModel: shopModel);
    result.fold((failed) => emit(AddNewProductErrorState(failed)),
        (r) => emit(AddNewProductSuccessState()));
  }

  getProductDetails({required int productId}) async {
    emit(GetProductDetailsLoadingState());
    var result = await uesCase.callGetProductDetails(productId: productId);
    result.fold((error) => emit(GetProductDetailsErrorState(error)), (product) {
      productModel = product;
      emit(GetProductDetailsSuccessState());
    });
  }

  deleteProduct({required int productId}) async {
    emit(DeleteProductLoadingState());
    var result = await uesCase.callDeleteProduct(productId: productId);
    result.fold((error) => emit(DeleteProductErrorState(error)),
        (product) => emit(DeleteProductSuccessState(productId)));
  }
}
