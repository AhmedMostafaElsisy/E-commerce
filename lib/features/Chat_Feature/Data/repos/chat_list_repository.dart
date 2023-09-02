import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';
import '../../Domain/interfaces/chat_list_interface.dart';

class ChatListRepository extends ChatListRepositoryInterface {
  @override
  Future<BaseModel> getChatList({required int page, int limit = 10}) async {
    try {
      String apiEndPoint = '${ApiKeys.chatListKey}?page=$page';
      isError = false;
      debugPrint("here is you chat key $apiEndPoint");
      Response response = await DioHelper.getDate(url: apiEndPoint);

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
      return baseModel;
    }
  }

  @override
  Future<BaseModel> deleteChat({
    required int chatId,
  }) async {
    try {
      String apiEndPoint = ApiKeys.deleteConversation;
      FormData formData = FormData();
      formData.fields.add(
        MapEntry("id", "$chatId"),
      );
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
