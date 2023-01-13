import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:captien_omda_customer/features/store_product/presentation/logic/product_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/ues_cases/product_ues_cases.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.uesCase) : super(ProductInitialState());

  static ProductCubit get(context) => BlocProvider.of(context);
  final ProductUesCase uesCase;

  set _imageFile(XFile? value) {
    imageXFile = value;
  }

  XFile? imageXFile;
  List<TextEditingController> controllerList = [];
  late bool isDataFound;
  late ProductModel productModel;

  photoPicked(XFile xFile) {
    _imageFile = xFile;
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
      required String storeId}) async {
    emit(AddNewProductLoadingState());
    var result = await uesCase.callCreateNewProduct(
        productName: productName,
        productMainPrice: productMainPrice,
        productDiscountPrice: productDiscountPrice,
        productType: productType,
        productImage: productImage,
        productStates: productStates,
        productBrand: productBrand,
        productDescription: productDescription,
        storeId: storeId);
    result.fold((failed) => emit(AddNewProductErrorState(failed)),
        (r) => emit(AddNewProductSuccessState()));
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
    emit(AddNewProductLoadingState());
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
        productId: productId);
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
        (product) => emit(DeleteProductSuccessState()));
  }
}
