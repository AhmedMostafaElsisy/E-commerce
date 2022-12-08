import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/Constants/Keys/api_keys.dart';
import '../../../core/Error_Handling/custom_error.dart';
import '../../../core/Error_Handling/custom_exception.dart';
import '../../Interfaces/password_interface.dart';
import '../../Models/base_model.dart';
import '../Network/Dio_Exception_Handling/dio_helper.dart';

class PasswordRepository extends PasswordRepositoryInterface {
  @override
  Future<BaseModel> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword}) async {
    try {
      String _profileUrl = ApiKeys.changePasswordKey;
      FormData staticData = FormData();
      staticData.fields.clear();
      isError = false;
      staticData.fields.add(MapEntry('new_password', newPassword));
      staticData.fields
          .add(MapEntry('new_password_confirmation', confirmPassword));
      staticData.fields.add(MapEntry('old_password', oldPassword));
      Response response =
          await DioHelper.postData(url: _profileUrl, data: staticData);

      if (response.statusCode == 200) {
        isError = false;
        debugPrint('response of Profile_Cubit data ${response.data}');
        baseModel = BaseModel.fromJson(response.data);

        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg = CustomError(
          type: ex.type, imgPath: ex.imgPath, errorMassage: ex.errorMassage);
      return baseModel;
    }
  }

  @override
  Future<BaseModel> sendVerificationCodeToEmail({required String email}) async {
    try {
      String _profileUrl = '/customer/forgetPassword';
      FormData staticData = FormData();
      staticData.fields.clear();
      isError = false;
      staticData.fields.add(MapEntry('email', email));
      Response response =
      await DioHelper.postData(url: _profileUrl, data: staticData);

      if (response.statusCode == 200) {
        isError = false;
        debugPrint('response of Profile_Cubit data ${response.data}');
        baseModel = BaseModel.fromJson(response.data);

        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg = CustomError(
          type: ex.type, imgPath: ex.imgPath, errorMassage: ex.errorMassage);
      return baseModel;
    }
  }
  @override
  Future<BaseModel> resetPassword(
      {required String email,
      required String newPassword,
      required String confirmPassword}) async {
    try {
      String _profileUrl = ApiKeys.resetPasswordKey;
      FormData staticData = FormData();
      staticData.fields.clear();
      isError = false;
      staticData.fields.add(MapEntry('email', email));
      staticData.fields.add(MapEntry('password', newPassword));
      staticData.fields.add(MapEntry('password_confirmation', confirmPassword));
      Response response =
          await DioHelper.postData(url: _profileUrl, data: staticData);

      if (response.statusCode == 200) {
        isError = false;
        debugPrint('response of Profile_Cubit data ${response.data}');
        baseModel = BaseModel.fromJson(response.data);

        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg = CustomError(
          type: ex.type, imgPath: ex.imgPath, errorMassage: ex.errorMassage);
      return baseModel;
    }
  }
}
