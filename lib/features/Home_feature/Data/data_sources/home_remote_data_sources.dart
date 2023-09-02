import 'package:captien_omda_customer/core/Constants/Keys/api_keys.dart';
import 'package:captien_omda_customer/core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

abstract class HomeRemoteDataSourceInterface {
  ///get requests
  Future<Either<CustomException, BaseModel>> getBanners();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSourceInterface {
  @override
  Future<Either<CustomException, BaseModel>> getBanners() async {
    try {
      String pathUrl = ApiKeys.homeAdds;
      Response response = await DioHelper.getDate(url: pathUrl);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(ex);
    }
  }
}
