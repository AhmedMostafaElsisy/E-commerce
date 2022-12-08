import 'dart:developer';

import '../../Interfaces/otp_interface.dart';
import '../../../core/Error_Handling/custom_exception.dart';
import '../../Models/base_model.dart';
import '../Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../core/Error_Handling/custom_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OtpRepository extends OtpRepositoryInterface {
  /// Verify OTP
  @override
  Future<BaseModel> verifyAccount(
      {required String email, required String code}) async {
    isError = false;
    FormData staticData = FormData();

    try {
      staticData.fields.clear();
      String _pathUrl = '/customer/otp-check';
      staticData.fields.add(MapEntry('email', email));
      staticData.fields.add(MapEntry('otp_code', code));

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
  @override
  Future<BaseModel> forgetAccount({
    required String phoneNumber,
    required String code,
  }) async {
    isError = false;
    FormData staticData = FormData();

    try {
      staticData.fields.clear();
      String _pathUrl = '/customer/forget/code';
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

  /// Resend OTP
  @override
  Future<BaseModel> resendOTP({required String email}) async {
    isError = false;
    FormData staticData = FormData();

    try {
      staticData.fields.clear();
      String _pathUrl = "/customer/resend-otp";
      staticData.fields.add(MapEntry('email', email));

      Response response =
      await DioHelper.postData(url: _pathUrl, data: staticData);
      if (response.statusCode == 200) {
        log("this resend otp response ${response.data}");

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
