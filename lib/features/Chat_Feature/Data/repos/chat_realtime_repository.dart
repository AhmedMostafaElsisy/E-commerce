import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/model/base_model.dart';
import '../../Domain/interfaces/chat_realtime_interface.dart';

class ChatRealTimeRepository extends ChatRealTimeRepositoryInterface {
  @override
  Future<BaseModel> authYouOnChat({required String socketId}) async {
    try {
      FormData formData = FormData();
      String apiEndPoint = ApiKeys.chatAuth;
      isError = false;
      formData.fields.add(MapEntry("socket_id", socketId));
      formData.fields.add(MapEntry(
          "channel_name", "private-chatify.${SharedText.currentUser?.id}"));
      Response response = await DioHelper.postData(
        url: apiEndPoint,
        data: formData,
      );

      if (response.statusCode == 200) {
        isError = false;
        debugPrint("user now are auth with ${response.data}");
        baseModel = BaseModel.fromJson(response.data);

        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg = ex.error;
      return baseModel;
    }
  }
}
