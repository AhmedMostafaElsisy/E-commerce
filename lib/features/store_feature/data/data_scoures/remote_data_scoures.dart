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
import '../../../../core/tags_feature/domain/model/tags_model.dart';

abstract class StoreRemoteDataSourceInterface {
  Future<Either<CustomError, BaseModel>> getStoreData(
      {int page = 1, int? limit});

  Future<Either<CustomError, BaseModel>> getStoreProductData(
      {required int shopId, int page = 1, int? limit});

  Future<Either<CustomError, BaseModel>> createStore({
    required XFile storeImage,
    required String storeName,
    required String ownerName,
    required String storeNumber,
    required String storeEmail,
    required String storeAddress,
    required String storeCity,
    required String storeArea,
    required String storeMainCategory,
    required List<TagsModel> storeSubCategory,
    int? planId,
  });

  Future<Either<CustomError, BaseModel>> editStore({
    required int storeId,
    XFile? storeImage,
    required String storeName,
    required String ownerName,
    required String storeNumber,
    required String storeEmail,
    required String storeAddress,
    required String storeCity,
    required String storeArea,
    required String storeMainCategory,
    required List<TagsModel> storeSubCategory,
    int? planId,
  });
}

class StoreRemoteDataSourceImpl extends StoreRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> createStore({
    required XFile storeImage,
    required String storeName,
    required String ownerName,
    required String storeNumber,
    required String storeEmail,
    required String storeAddress,
    required String storeCity,
    required String storeArea,
    required String storeMainCategory,
    required List<TagsModel> storeSubCategory,
    int? planId,
  }) async {
    try {
      String pathUrl = ApiKeys.addStoreKey;

      FormData staticData = FormData();
      var tags = [];
      for (var element in storeSubCategory) {
        tags.add(element.id);
      }
      Map<String, dynamic> postData = {
        "store_name": storeName,
        "username": ownerName,
        "phone": storeNumber,
        "email": storeEmail,
        "address": storeAddress,
        "city": storeCity,
        "area": storeArea,
        "category_id": storeMainCategory,
        "tag_id": tags,
        'image': await MultipartFile.fromFile(
          storeImage.path,
          filename: storeImage.path.split("/").last.toString(),
        ),
        "plan_id": planId
      };

      log("this the update data $postData");
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
  Future<Either<CustomError, BaseModel>> getStoreData(
      {int page = 1, int? limit}) async {
    try {
      String pathUrl = "";
      if (limit == null) {
        pathUrl = "${ApiKeys.myStoreListKey}?page=$page";
      } else {
        pathUrl = "${ApiKeys.myStoreListKey}?limit=$limit&page=$page";
      }

      Response response = await DioHelper.getDate(url: pathUrl);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> editStore({
    required int storeId,
    XFile? storeImage,
    required String storeName,
    required String ownerName,
    required String storeNumber,
    required String storeEmail,
    required String storeAddress,
    required String storeCity,
    required String storeArea,
    required String storeMainCategory,
    required List<TagsModel> storeSubCategory,
    int? planId,
  }) async {
    try {
      String pathUrl = ApiKeys.updateStoreKey;

      FormData staticData = FormData();
      var tags = [];
      for (var element in storeSubCategory) {
        tags.add(element.id);
      }

      Map<String, dynamic> postData = {
        "store_id": storeId,
        "store_name": storeName,
        "username": ownerName,
        "phone": storeNumber,
        "email": storeEmail,
        "address": storeAddress,
        "city": storeCity,
        "area": storeArea,
        "category_id": storeMainCategory,
        "tag_id": tags,
        'image': storeImage == null
            ? null
            : await MultipartFile.fromFile(
                storeImage.path,
                filename: storeImage.path.split("/").last.toString(),
              ),
        "plan_id": planId
      };

      log("this the update data $postData");
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
  Future<Either<CustomError, BaseModel>> getStoreProductData(
      {required int shopId, int page = 1, int? limit}) async {
    try {
      String pathUrl = "";
      if (limit == null) {
        pathUrl = "${ApiKeys.showStoreKey}?store_id=$shopId&page=$page";
      } else {
        pathUrl =
            "${ApiKeys.showStoreKey}?store_id=$shopId&limit=$limit&page=$page";
      }

      Response response = await DioHelper.getDate(url: pathUrl);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
  }
}
