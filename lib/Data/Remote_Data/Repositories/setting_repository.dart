import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../Interfaces/settings_interface.dart';
import '../../../core/Error_Handling/custom_error.dart';
import '../../../core/Error_Handling/custom_exception.dart';
import '../../Models/base_model.dart';
import '../Network/Dio_Exception_Handling/dio_helper.dart';

class SettingRepository extends SettingInterfaceRepository {
  @override
  Future<Either<CustomError, BaseModel>> getTermsAndConditions() async {
    isError = false;

    try {
      String _pathUrl = '/terms';
      log("i am here from terms repo passing by di");
      Response response = await DioHelper.getDate(
        url: _pathUrl,
      );
      if (response.statusCode == 200) {
        /// parsing response to user model
        baseModel = BaseModel.fromJson(response.data);
        return Right(baseModel);
      } else {
        return Right(baseModel);
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg = CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath);
      return Left(errorMsg!);
    }
  }

  @override
  Future<BaseModel> getFqa() async {
    isError = false;

    try {
      String _pathUrl = '/faqs';

      Response response = await DioHelper.getDate(
        url: _pathUrl,
      );
      if (response.statusCode == 200) {
        /// parsing response to user model
        baseModel = BaseModel.fromJson(response.data);
        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg = CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath);
      return baseModel;
    }
  }
}
