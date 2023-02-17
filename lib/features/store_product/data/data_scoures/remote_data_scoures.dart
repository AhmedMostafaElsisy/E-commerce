import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/model/shop_model.dart';

abstract class ProductRemoteDataSourceInterface {
  Future<Either<CustomError, BaseModel>> createProduct(
      {required String productName,
      required String productMainPrice,
      required String productDiscountPrice,
      required String productType,
      required List<XFile> productImage,
      required String productStates,
      required String productBrand,
      required String productDescription,
      required ShopModel shopModel});

  Future<Either<CustomError, BaseModel>> editProduct(
      {required String productName,
      required String productMainPrice,
      required String productDiscountPrice,
      required String productType,
      List<XFile>? productImage,
      required String productStates,
      required String productBrand,
      required String productDescription,
      required String storeId,
      required String productId,
      required ShopModel shopModel});

  Future<Either<CustomError, BaseModel>> getProductDetails(
      {required int productId});

  Future<Either<CustomError, BaseModel>> deleteProductDetails(
      {required int productId});
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> createProduct(
      {required String productName,
      required String productMainPrice,
      required String productDiscountPrice,
      required String productType,
      required List<XFile> productImage,
      required String productStates,
      required String productBrand,
      required String productDescription,
      required ShopModel shopModel}) async {
    try {
      String pathUrl = ApiKeys.addProductKey;

      FormData staticData = FormData();
      var photoList = [];
      for (var element in productImage) {
        photoList.add(await MultipartFile.fromFile(
          element.path,
          filename: element.path.split("/").last.toString(),
        ));
      }
      Map<String, dynamic> postData = {
        "name": productName,
        "description": productDescription,
        "images": photoList,
        "price": productMainPrice,
        "discount": productDiscountPrice,
        "type": productType,
        "category_id": productBrand,
        "city_id": shopModel.city!.id,
        "area_id": shopModel.area!.id,
        "store_id": shopModel.id,
        "weight": 0
      };
      staticData = FormData.fromMap(
        postData,
        ListFormat.multiCompatible,
      );

      Response response =
          await DioHelper.postData(url: pathUrl, data: staticData);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> editProduct(
      {required String productName,
      required String productMainPrice,
      required String productDiscountPrice,
      required String productType,
      List<XFile>? productImage,
      required String productStates,
      required String productBrand,
      required String productDescription,
      required String storeId,
      required String productId,
      required ShopModel shopModel}) async {
    try {
      String pathUrl = ApiKeys.addProductKey;

      FormData staticData = FormData();
      var photoList = [];
      if (productImage != null && productImage.isNotEmpty) {
        for (var element in productImage) {
          photoList.add({
            "value": await MultipartFile.fromFile(
              element.path,
              filename: element.path.split("/").last.toString(),
            )
          });
        }
      }
      Map<String, dynamic> postData = {
        "name": productName,
        "description": productDescription,
        "images": photoList,
        "price": productMainPrice,
        "discount": productDiscountPrice,
        "type": productType,
        "category_id": productBrand,
        "city_id": shopModel.city!.id,
        "area_id": shopModel.area!.id,
        "store_id": shopModel.id,
        "weight": 0,
        "product_id": productId
      };
      staticData = FormData.fromMap(
        postData,
        ListFormat.multiCompatible,
      );
      log("this edit data ${postData}");
      Response response =
          await DioHelper.postData(url: pathUrl, data: staticData);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> deleteProductDetails(
      {required int productId}) async {
    try {
      String pathUrl = ApiKeys.deleteProductKey;
      FormData staticData = FormData();
      staticData.fields.add(MapEntry('product_id', productId.toString()));
      Response response =
          await DioHelper.postData(url: pathUrl, data: staticData);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> getProductDetails(
      {required int productId}) async {
    try {
      String pathUrl = "${ApiKeys.showProductKey}?product_id=$productId";

      Response response = await DioHelper.getDate(
        url: pathUrl,
      );

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
  }
}
