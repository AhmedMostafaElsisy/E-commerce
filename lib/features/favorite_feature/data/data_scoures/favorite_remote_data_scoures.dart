import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
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
      String pathUrl = ApiKeys.addFavoriteKey;
      FormData data = FormData();
      data.fields.add(MapEntry('product_id', productId.toString()));

      Response response = await DioHelper.postData(url: pathUrl, data: data);

      return right(BaseModel.fromJson(response.data));
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
      String pathUrl = "";
      if (limit == null) {
        pathUrl = "${ApiKeys.favoriteKey}?page=$page";
      } else {
        pathUrl = "${ApiKeys.favoriteKey}?limit=$limit&page=$page";
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
  Future<Either<CustomError, BaseModel>> removeFromFavorite(
      {required int productId}) async {
    try {
      String pathUrl = ApiKeys.removeFavoriteKey;
      FormData data = FormData();
      data.fields.add(MapEntry('product_id', productId.toString()));

      Response response = await DioHelper.postData(url: pathUrl, data: data);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
  }
}
