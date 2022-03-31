import 'package:default_repo_app/Data/Models/base_model.dart';
import 'package:default_repo_app/Data/Network/Dio_Exception_Handling/custom_error.dart';
import 'package:default_repo_app/Data/Network/Dio_Exception_Handling/custom_exception.dart';
import 'package:default_repo_app/Data/Network/Dio_Exception_Handling/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository {
  BaseModel baseModel = BaseModel();
  CustomError? errorMsg;
  bool isError = false;

  /// singUp user to app
  Future<BaseModel> userSingUp(
      {required String phoneNumber,
      required String password,
      required String name,
      required String email}) async {
    isError = false;
    FormData staticData = FormData();

    try {
      staticData.fields.clear();
      String _pathUrl = '/register';
      staticData.fields.add(MapEntry('phone', phoneNumber));
      staticData.fields.add(MapEntry('password', password));
      staticData.fields.add(MapEntry('email', email));
      staticData.fields.add(MapEntry('name', name));

      Response response =
          await DioHelper.postData(url: _pathUrl, data: staticData);
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

  /// login user to app
  Future<BaseModel> loginUser({
    required String phoneNumber,
    required String password,
    // required deviceToken,
  }) async {
    isError = false;
    FormData staticData = FormData();

    try {
      staticData.fields.clear();
      String loginUrl = '/login';
      staticData.fields.add(MapEntry('phone', phoneNumber));
      staticData.fields.add(MapEntry('password', password));

      Response response =
          await DioHelper.postData(url: loginUrl, data: staticData);
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

  ///auth user Profile_Cubit data
  Future<BaseModel> getProfileUser() async {
    try {
      String _profileUrl = '/me';
      isError = false;
      Response response = await DioHelper.getDate(url: _profileUrl);

      if (response.statusCode == 200) {
        isError = false;
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

  ///update auth user Profile_Cubit data
  Future<BaseModel> updateProfile(
      {String? name, String? email, XFile? userImage}) async {
    try {
      String _profileUrl = '/update/Profile_Cubit';
      isError = false;
      FormData staticData = FormData();
      staticData.fields.clear();

      if (name != null) {
        staticData.fields.add(MapEntry('name', name));
      }
      if (email != null) {
        staticData.fields.add(MapEntry('email', email));
      }
      if (userImage != null) {
        staticData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(
            userImage.path,
            filename: userImage.path.split("/").last.toString(),
          ),
        ));
        debugPrint('fields data ${staticData.files.toString()}');
      }
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
}
