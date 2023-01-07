import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

abstract class RatingRemoteDataSourceInterface {
  ///get requests
  Future<Either<CustomError, BaseModel>> addRating(
      {required int driverId,
      required int requestId,
      required int rate,
      required String comment});
}

class RatingRemoteDataSourceImpl extends RatingRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> addRating(
      {required int driverId,
      required int requestId,
      required int rate,
      required String comment}) async {
    try {
      FormData staticData = FormData();

      String pathUrl = ApiKeys.ratingKey;
      staticData.fields.add(MapEntry('driver_id', driverId.toString()));
      staticData.fields.add(MapEntry('request_id', requestId.toString()));
      staticData.fields.add(MapEntry('rate', rate.toString()));
      if (comment.isNotEmpty) {
        staticData.fields.add(MapEntry('comment', comment.toString()));
      }
      log("this the rating form ${staticData.fields}");
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
}
