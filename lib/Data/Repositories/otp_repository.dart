import 'package:default_repo_app/Data/Models/base_model.dart';
import 'package:default_repo_app/Data/Network/Dio_Exception_Handling/custom_error.dart';
import 'package:default_repo_app/Data/Network/Dio_Exception_Handling/custom_exception.dart';
import 'package:default_repo_app/Data/Network/Dio_Exception_Handling/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OtpRepository {
  BaseModel baseModel = BaseModel();
  CustomError? errorMsg;
  bool isError = false;

  /// Verify OTP
  Future<BaseModel> verifyAccount(
      {required String phoneNumber, required String code}) async {
    isError = false;
    FormData staticData = FormData();

    try {
      staticData.fields.clear();
      String _pathUrl = '/verify/account';
      staticData.fields.add(MapEntry('phone', phoneNumber));
      staticData.fields.add(MapEntry('code', code));

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
      errorMsg = CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath);
      return baseModel;
    }
  }

  /// singUp user to app
  Future<BaseModel> forgetAccount({
    required String phoneNumber,
    required String code,
  }) async {
    isError = false;
    FormData staticData = FormData();

    try {
      staticData.fields.clear();
      String _pathUrl = '/forget/code';
      staticData.fields.add(MapEntry('phone', phoneNumber));
      staticData.fields.add(MapEntry('code', code));

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
      errorMsg = CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath);
      return baseModel;
    }
  }
}
