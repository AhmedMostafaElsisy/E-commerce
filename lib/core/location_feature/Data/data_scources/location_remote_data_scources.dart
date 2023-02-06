import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

abstract class LocationRemoteDataSourceInterface {


  Future<Either<CustomError, BaseModel>> getCityData(
      {int page = 1, int limit = 10, required int countryId});

  Future<Either<CustomError, BaseModel>> getAreaData(
      {int page = 1, int limit = 10, required int cityId});
}

class LocationRemoteDataSourceImpl extends LocationRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> getAreaData(
      {int page = 1, int limit = 10, required int cityId}) async {
    try {

      String pathUrl = "${ApiKeys.areaListKey}?city_id=$cityId&limit=$limit&page=$page";

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
  Future<Either<CustomError, BaseModel>> getCityData(
      {int page = 1, int limit = 10, required int countryId}) async {
    try {
      ///Todo: add country id
      String pathUrl = "";
      pathUrl = "${ApiKeys.cityListKey}?limit=$limit&page=$page";

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
