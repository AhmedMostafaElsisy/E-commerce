import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

abstract class OrderRemoteDataSourceInterface {
  Future<Either<CustomError, BaseModel>> getOrderData(
      {int page = 1, int? limit});

  Future<Either<CustomError, BaseModel>> getOrderDetails(
      {required int orderID});
}

class OrderRemoteDataSourceImpl extends OrderRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> getOrderDetails(
      {required int orderID}) async {
    try {
      String pathUrl = "${ApiKeys.showOrderKey}?order_id=$orderID";

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
  Future<Either<CustomError, BaseModel>> getOrderData(
      {int page = 1, int? limit}) async {
    try {
      String pathUrl = "";
      if (limit == null) {
        pathUrl = "${ApiKeys.orderListKey}?page=$page";
      } else {
        pathUrl = "${ApiKeys.orderListKey}?limit=$limit&page=$page";
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
