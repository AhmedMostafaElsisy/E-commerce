import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

abstract class PlansRemoteDataSourceInterface {


  Future<Either<CustomError, BaseModel>> getPlans(
      {int page = 1, int limit = 10,});


}

class PlansRemoteDataSourceImpl extends PlansRemoteDataSourceInterface {


  @override
  Future<Either<CustomError, BaseModel>> getPlans(
      {int page = 1, int limit = 10,}) async {
    try {

      String pathUrl  = "${ApiKeys.plansKey}?limit=$limit&page=$page";

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
