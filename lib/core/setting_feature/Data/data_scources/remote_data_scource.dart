import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_exception.dart';

abstract class SettingRemoteDataSourceInterface {
  Future<Either<CustomError, BaseModel>> getSettingData();
  Future<Either<CustomError, BaseModel>> getTerms();
}

class SettingRemoteDataSourceImpl extends SettingRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> getSettingData() async {
    try {
      String pathUrl = ApiKeys.settingKey;

      Response response = await DioHelper.getDate(url: pathUrl);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left( ex.error);
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> getTerms() async {
    try {
      String pathUrl = ApiKeys.termsKey;

      Response response = await DioHelper.getDate(url: pathUrl);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left( ex.error);
    }
  }
}
