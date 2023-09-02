import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

abstract class GeneralStoresRemoteDataSourceInterface {
  Future<Either<CustomError, BaseModel>> getStoreData(
      {int page = 1, int? limit});

  Future<Either<CustomError, BaseModel>> getStoreProductData(
      {required int shopId, int page = 1, int? limit});
}

class GeneralStoresRemoteDataSourceImpl
    extends GeneralStoresRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> getStoreData(
      {int page = 1, int? limit}) async {
    try {
      String pathUrl = "";
      if (limit == null) {
        pathUrl = "${ApiKeys.homeStoresKey}?page=$page";
      } else {
        pathUrl = "${ApiKeys.homeStoresKey}?limit=$limit&page=$page";
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
  Future<Either<CustomError, BaseModel>> getStoreProductData(
      {required int shopId, int page = 1, int? limit}) async {
    try {
      String pathUrl = "";
      if (limit == null) {
        pathUrl = "${ApiKeys.productOfStoreKey}?storeId=$shopId&page=$page";
      } else {
        pathUrl =
            "${ApiKeys.productOfStoreKey}?store_id=$shopId&limit=$limit&page=$page";
      }
      await Future.delayed(const Duration(seconds: 3));

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
