import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

abstract class LocationRemoteDataSourceInterface {
  ///get requests
  Future<Either<CustomError, BaseModel>> getLocationData(
      {int? page = 1, String? searchKey});
}

class LocationRemoteDataSourceImpl extends LocationRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> getLocationData(
      {int? page = 1, String? searchKey}) async {
    try {
      String pathUrl = "";
      if (searchKey != null) {
        pathUrl = "${ApiKeys.locationListKey}?search=$searchKey";
      } else {
        pathUrl = ApiKeys.locationListKey;
      }

      Response response = await DioHelper.getDate(url: pathUrl);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }
}
