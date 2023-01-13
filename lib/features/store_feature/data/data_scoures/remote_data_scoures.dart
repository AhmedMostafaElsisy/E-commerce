import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

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
    required String storeSubCategory,
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
    required String storeSubCategory,
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
    required String storeSubCategory,
  }) async {
    try {
      String pathUrl = ApiKeys.storeKey;
      FormData staticData = FormData();
      staticData.fields.add(MapEntry('store_name', storeName));
      staticData.fields.add(MapEntry('owner_name', ownerName));
      staticData.fields.add(MapEntry('store_phone', storeNumber));
      staticData.fields.add(MapEntry('store_email', storeEmail));
      staticData.fields.add(MapEntry('store_address', storeAddress));
      staticData.fields.add(MapEntry('store_city', storeCity));
      staticData.fields.add(MapEntry('store_area', storeArea));
      staticData.fields.add(MapEntry('store_category', storeMainCategory));
      staticData.fields.add(MapEntry('store_subCategory', storeSubCategory));
      staticData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(
            storeImage.path,
            filename: storeImage.path.split("/").last.toString(),
          )));

      // Response response = await DioHelper.postData(url: pathUrl, data: staticData);
      Map<String, dynamic> dataMap = {
        "code": 200,
        "massage": "success",
      };
      await Future.delayed(const Duration(seconds: 3));

      return right(BaseModel.fromJson(dataMap));
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
      Map<String, dynamic> data = {
        "code": 200,
        "massage": "success",
        "data": [
          {
            "id": 1,
            "shop_name": "متجر الكتروني",
            "shop_image":
                "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
            "category": "electronic",
            "location": "cairo",
            "phone": "0100000",
            "email": "abc@gmail.com",
            "owner_name": "ahmed",
            "city": "cairo",
            "area": "cairo",
            "sub_category": "electronic , hardware",
            "rate": "2"
          },
          {
            "id": 1,
            "shop_name": "متجر الكتروني",
            "shop_image":
                "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
            "category": "electronic",
            "location": "cairo",
            "phone": "0100000",
            "email": "abc@gmail.com",
            "owner_name": "ahmed",
            "city": "cairo",
            "area": "cairo",
            "sub_category": "electronic , hardware",
            "rate": "2"
          },
        ]
      };
      String pathUrl = "";
      if (limit == null) {
        pathUrl = "${ApiKeys.favoriteKey}?page=$page";
      } else {
        pathUrl = "${ApiKeys.favoriteKey}?limit=$limit&page=$page";
      }
      await Future.delayed(const Duration(seconds: 3));

      // Response response = await DioHelper.getDate(url: pathUrl);
      return right(BaseModel.fromJson(data));
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
    required String storeSubCategory,
  }) async {
    try {
      String pathUrl = ApiKeys.storeKey;

      FormData staticData = FormData();
      staticData.fields.add(MapEntry('store_id', storeId.toString()));
      staticData.fields.add(MapEntry('store_name', storeName));
      staticData.fields.add(MapEntry('owner_name', ownerName));
      staticData.fields.add(MapEntry('store_phone', storeNumber));
      staticData.fields.add(MapEntry('store_email', storeEmail));
      staticData.fields.add(MapEntry('store_address', storeAddress));
      staticData.fields.add(MapEntry('store_city', storeCity));
      staticData.fields.add(MapEntry('store_area', storeArea));
      staticData.fields.add(MapEntry('store_category', storeMainCategory));
      staticData.fields.add(MapEntry('store_subCategory', storeSubCategory));
      if (storeImage != null) {
        staticData.files.add(MapEntry(
            'image',
            await MultipartFile.fromFile(
              storeImage.path,
              filename: storeImage.path.split("/").last.toString(),
            )));
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
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> getStoreProductData(
      {required int shopId, int page = 1, int? limit}) async {
    try {
      Map<String, dynamic> data = {
        "code": 200,
        "massage": "success",
        "data": [
          {
            "id": 1,
            "product_name": "product one",
            "product_image":
                "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHw%3D&w=1000&q=80",
            "price": "1500",
            "description": "electronic , photos",
            "time": "15h",
            "is_fav": true,
            "shop": {
              "id": 1,
              "shop_name": "متجر الكتروني",
              "shop_image":
              "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
              "category": "electronic",
              "location": "cairo",
              "phone": "0100000",
              "email": "abc@gmail.com",
              "owner_name": "ahmed",
              "city": "cairo",
              "area": "cairo",
              "sub_category": "electronic , hardware",
              "rate": "2"
            }
          },
          {
            "id": 2,
            "product_name": "product one",
            "product_image":
                "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHw%3D&w=1000&q=80",
            "price": "1500",
            "description": "electronic , photos",
            "time": "15h",
            "is_fav": true,
            "shop": {
              "id": 1,
              "shop_name": "متجر الكتروني",
              "shop_image":
              "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
              "category": "electronic",
              "location": "cairo",
              "phone": "0100000",
              "email": "abc@gmail.com",
              "owner_name": "ahmed",
              "city": "cairo",
              "area": "cairo",
              "sub_category": "electronic , hardware",
              "rate": "2"
            }
          },
          {
            "id": 3,
            "product_name": "product one",
            "product_image":
                "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHw%3D&w=1000&q=80",
            "price": "1500",
            "description": "electronic , photos",
            "time": "15h",
            "is_fav": false,
            "shop": {
              "id": 1,

              "shop_name": "متجر الكتروني",
              "shop_image":
              "https://m.media-amazon.com/images/G/01/gc/designs/livepreview/amazon_dkblue_noto_email_v2016_us-main._CB468775337_.png",
              "category": "electronic",
              "location": "cairo",
              "phone": "0100000",
              "email": "abc@gmail.com",
              "owner_name": "ahmed",
              "city": "cairo",
              "area": "cairo",
              "sub_category": "electronic , hardware",
              "rate": "2"
            }
          },
        ]
      };

      String pathUrl = "";
      if (limit == null) {
        pathUrl = "${ApiKeys.productKey}?storeId=$shopId&page=$page";
      } else {
        pathUrl =
            "${ApiKeys.productKey}?storeId=$shopId&limit=$limit&page=$page";
      }
      await Future.delayed(const Duration(seconds: 3));

      // Response response = await DioHelper.getDate(url: pathUrl);
      return right(BaseModel.fromJson(data));
    } on CustomException catch (ex) {
      return Left(CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
  }
}
