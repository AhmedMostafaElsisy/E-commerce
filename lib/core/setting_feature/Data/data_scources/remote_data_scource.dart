import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Error_Handling/custom_exception.dart';

abstract class SettingRemoteDataSourceInterface {
  ///change password
  Future<Either<CustomError, BaseModel>> getSettingData();
}

class SettingRemoteDataSourceImpl extends SettingRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> getSettingData() async {
    try {
      String pathUrl = ApiKeys.settingKey;

      Response response = await DioHelper.getDate(url: pathUrl);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }
}
