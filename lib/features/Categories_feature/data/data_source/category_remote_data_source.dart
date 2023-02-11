import 'package:captien_omda_customer/core/Error_Handling/custom_exception.dart';
import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';

abstract class CategoryRemoteDataSourceInterface {
  Future<Either<CustomException, BaseModel>> getCategoriesData();
}

class CategoryRemoteDataSourceImplementation
    extends CategoryRemoteDataSourceInterface {
  @override
  Future<Either<CustomException, BaseModel>> getCategoriesData() async {
    try {
      String pathUrl = ApiKeys.categoryKey;

      Response response = await DioHelper.getDate(url: pathUrl, );


      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(ex);
    }
  }
}
