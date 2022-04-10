import 'package:default_repo_app/Data/Interfaces/password_interface.dart';
import 'package:default_repo_app/Data/Models/base_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../Network/Dio_Exception_Handling/custom_error.dart';
import '../Network/Dio_Exception_Handling/custom_exception.dart';
import '../Network/Dio_Exception_Handling/dio_helper.dart';

class PasswordRepository extends PasswordRepositoryInterface {
  @override
  Future<BaseModel> changePassword(
      {required String currentPassword,
        required String newPassword,
        required String confirmPassword}) async {
    try {
      String _profileUrl = '/change/password';
      FormData staticData = FormData();
      staticData.fields.clear();
      isError = false;
      staticData.fields.add(MapEntry('current', currentPassword));
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


  @override
  Future<BaseModel> forgetPassword({required String phoneNumber}) async {
    try {
      String _profileUrl = '/forget/password';
      FormData staticData = FormData();
      staticData.fields.clear();
      isError = false;
      staticData.fields.add(MapEntry('phone', phoneNumber));
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