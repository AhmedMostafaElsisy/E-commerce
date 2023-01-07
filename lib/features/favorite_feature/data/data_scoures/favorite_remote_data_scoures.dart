import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

//todo:need to handel it with cc talks about exceptions
abstract class FavoriteRemoteDataSourceInterface {
  Future<Either<CustomError, BaseModel>> getFavoriteData(
      {int page = 1, int? limit});

  Future<Either<CustomError, BaseModel>> addToFavorite(
      {required int productId});

  Future<Either<CustomError, BaseModel>> removeFromFavorite(
      {required int productId});
}

class FavoriteRemoteDataSourceImpl extends FavoriteRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> addToFavorite(
      {required int productId}) async {
    try {
      String pathUrl = "${ApiKeys.favoriteKey}?id?=$productId";
      FormData data = FormData();

      // Response response = await DioHelper.postData(url: pathUrl, data: data);
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
  Future<Either<CustomError, BaseModel>> getFavoriteData(
      {int page = 1, int? limit}) async {
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
              "location": "cairo"
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
              "location": "cairo"
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
              "location": "cairo"
            }
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
  Future<Either<CustomError, BaseModel>> removeFromFavorite(
      {required int productId}) async {
    try {
      String pathUrl = "${ApiKeys.favoriteKey}?id?=$productId";

      // Response response = await DioHelper.deleteData(url: pathUrl);

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
}
