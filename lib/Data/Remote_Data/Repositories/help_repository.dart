import '../../../core/Error_Handling/custom_exception.dart';
import '../../Models/base_model.dart';
import '../Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../core/Error_Handling/custom_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HelpRepository {
  BaseModel baseModel = BaseModel();
  CustomError? errorMsg;
  bool isError = false;

  /// singUp user to app
  Future<BaseModel> helpUser({
    required String phoneNumber,
    required String name,
    required String subject,
    required String massage,
  }) async {
    isError = false;
    FormData staticData = FormData();

    try {
      staticData.fields.clear();
      String _pathUrl = '/contact/us';
      staticData.fields.add(MapEntry('name', name));
      staticData.fields.add(MapEntry('phone', phoneNumber));
      staticData.fields.add(MapEntry('subject', subject));
      staticData.fields.add(MapEntry('msg', massage));

      Response response =
          await DioHelper.postData(url: _pathUrl, data: staticData);
      if (response.statusCode == 200) {
        /// parsing response to user model
        baseModel = BaseModel.fromJson(response.data);
        debugPrint(baseModel.data.toString());
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
