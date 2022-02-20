import 'package:default_repo_app/Data/Dio_Exception_Handling/custom_error.dart';
import 'package:default_repo_app/Data/Dio_Exception_Handling/custom_exception.dart';
import 'package:default_repo_app/Data/Dio_Exception_Handling/dio_helper.dart';
import 'package:default_repo_app/Logic/Models/base_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ForgetPasswordRepository {
  BaseModel baseModel = BaseModel();
  CustomError? errorMsg;
  bool isError = false;

  Future<BaseModel> resetPassword({
    required String phoneNumber,
    required String password,
    required String newPassword,
  }) async {
    isError = false;
    FormData staticData = FormData();

    try {
      staticData.fields.clear();
      String _pathUrl = '/reset/password';
      staticData.fields.add(MapEntry('phone', phoneNumber));
      staticData.fields.add(MapEntry('password', password));
      staticData.fields.add(MapEntry('password_confirmation', newPassword));

      Response response =
          await DioHelper.postData(url: _pathUrl, data: staticData);
      if (response.statusCode == 200) {
        /// parsing response to user model
        baseModel = BaseModel.fromJson(response.data);
        debugPrint(baseModel.data);
        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      debugPrint(" this is the erro ${ex.type}");
      errorMsg = CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath);
      return baseModel;
    }
  }
}
