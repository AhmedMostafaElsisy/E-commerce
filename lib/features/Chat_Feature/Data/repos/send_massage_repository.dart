import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/Constants/Enums/chat/massage_type.dart';
import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';
import '../../Domain/interfaces/send_massage_interface.dart';

class SendMassageRepository extends SendChatMassageInterface {
  @override
  Future<BaseModel> sendChatMassage(
      {required int receiverId,
      String? massageText,
      String? massageFile,
      required MassageType massageType}) async {
    try {
      String apiEndPoint = ApiKeys.sendMassageKey;
      FormData formData = FormData();
      formData.fields.add(MapEntry("id", "$receiverId"));
      formData.fields.add(const MapEntry("type", "user"));
      // formData.fields.add(const MapEntry("temporaryMsgId", "temp_1"));
      if (massageText != null) {
        formData.fields.add(MapEntry("message", massageText));
      }
      if (massageFile != null) {
        formData.files.add(
          MapEntry(
            "file",
            await MultipartFile.fromFile(massageFile,
                filename: massageFile.split('/').last),
          ),
        );
      }

      isError = false;
      Response response =
          await DioHelper.postData(url: apiEndPoint, data: formData);

      if (response.statusCode == 200) {
        isError = false;
        baseModel = BaseModel.fromJson(response.data);

        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      debugPrint("error from send chat ${ex.toString()}");

      isError = true;
      errorMsg = ex.error;
      rethrow;
    }
  }

  @override
  Future<BaseModel> fetchMassageList({required int receiverId}) async {
    try {
      String apiEndPoint = ApiKeys.fetchMassageKey;
      FormData formData = FormData();
      formData.fields.add(MapEntry("id", "$receiverId"));
      isError = false;
      Response response =
          await DioHelper.postData(url: apiEndPoint, data: formData);

      if (response.statusCode == 200) {
        isError = false;
        baseModel = BaseModel.fromJson(response.data);

        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg = ex.error;
      rethrow;
    }
  }
}
