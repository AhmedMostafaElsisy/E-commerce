import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

abstract class RequestRemoteDataSourceInterface {
  ///get requests
  Future<Either<CustomError, BaseModel>> getRequestData(
      {int page = 1, int? limit});

  Future<Either<CustomError, BaseModel>> startRequest(
      {required int fromLocationId, required int toLocationId});

  Future<Either<CustomError, BaseModel>> changeRequestStates(
      {required int requestID, required String states});

  Future<Either<CustomError, BaseModel>> getCurrentRequest();
}

class RequestRemoteDataSourceImpl extends RequestRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> getRequestData(
      {int page = 1, int? limit}) async {
    try {
      String pathUrl = "";
      if (limit == null) {
        pathUrl = ApiKeys.requestListKey;
      } else {
        pathUrl = "${ApiKeys.requestListKey}?limit=$limit";
      }
      Response response = await DioHelper.getDate(url: pathUrl);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> startRequest(
      {required int fromLocationId, required int toLocationId}) async {
    try {
      FormData staticData = FormData();

      String pathUrl = ApiKeys.requestStoreKey;
      staticData.fields.add(MapEntry('from_id', fromLocationId.toString()));
      staticData.fields.add(MapEntry('to_id', toLocationId.toString()));
      Response response =
          await DioHelper.postData(url: pathUrl, data: staticData);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> changeRequestStates(
      {required int requestID, required String states}) async {
    try {
      FormData staticData = FormData();

      String pathUrl = ApiKeys.requestStatesKey;
      staticData.fields.add(MapEntry('id', requestID.toString()));
      staticData.fields.add(MapEntry('state', states.toString()));
      Response response =
          await DioHelper.postData(url: pathUrl, data: staticData);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> getCurrentRequest() async {
    try {
      String pathUrl = ApiKeys.currentRequestKey;

      Response response = await DioHelper.getDate(
        url: pathUrl,
      );

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }
}
