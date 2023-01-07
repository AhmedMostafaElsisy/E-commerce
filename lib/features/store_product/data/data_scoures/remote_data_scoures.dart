import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

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
      required String storeId});

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
      required String productId});
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
      required String storeId}) async {
    try {
      String pathUrl = ApiKeys.storeKey;
      FormData staticData = FormData();
      staticData.fields.add(MapEntry('product_name', productName));
      staticData.fields.add(MapEntry('product_price', productMainPrice));
      staticData.fields
          .add(MapEntry('product_discount_price', productDiscountPrice));

      staticData.fields.add(MapEntry('product_type', productType));
      staticData.fields.add(MapEntry('product_states', productStates));
      staticData.fields.add(MapEntry('product_brand', productBrand));
      staticData.fields.add(MapEntry('description', productDescription));
      staticData.fields.add(MapEntry('store_id', storeId));
      var photoList = [];

      for (var element in productImage) {
        photoList.add(await MultipartFile.fromFile(
          element.path,
          filename: element.path.split("/").last.toString(),
        ));
      }
      // Response response = await DioHelper.postData(url: pathUrl, data: staticData);
      Map<String, dynamic> dataMap = {
        "code": 200,
        "massage": "success",
      };
      await Future.delayed(const Duration(seconds: 3));

      return right(BaseModel.fromJson(dataMap));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
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
      required String productId}) async {
    try {
      String pathUrl = ApiKeys.storeKey;

      FormData staticData = FormData();
      staticData.fields.add(MapEntry('productId', productId));
      staticData.fields.add(MapEntry('product_name', productName));
      staticData.fields.add(MapEntry('product_price', productMainPrice));
      staticData.fields
          .add(MapEntry('product_discount_price', productDiscountPrice));

      staticData.fields.add(MapEntry('product_type', productType));
      staticData.fields.add(MapEntry('product_states', productStates));
      staticData.fields.add(MapEntry('product_brand', productBrand));
      staticData.fields.add(MapEntry('description', productDescription));
      staticData.fields.add(MapEntry('store_id', storeId));
      var photoList = [];

      if (productImage != null) {
        for (var element in productImage) {
          photoList.add(await MultipartFile.fromFile(
            element.path,
            filename: element.path.split("/").last.toString(),
          ));
        }
      }

      // Response response = await DioHelper.postData(url: pathUrl, data: staticData);

      Map<String, dynamic> dataMap = {
        "code": 200,
        "massage": "success",
      };
      await Future.delayed(const Duration(seconds: 3));
      return right(BaseModel.fromJson(dataMap));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }
}
