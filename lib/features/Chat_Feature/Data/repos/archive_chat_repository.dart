import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';
import '../../Domain/interfaces/chat_archive_interface.dart';

class ArchiveChatsRepository extends ArchiveChatsRepositoryInterface {
  @override
  Future<BaseModel> getArchiveChats({required int page, int limit = 10}) async {
    try {
      String apiEndPoint = ApiKeys.archiveListKey;
      debugPrint("here is apiEndPoint Data $apiEndPoint");

      isError = false;
      Response response = await DioHelper.getDate(
        url: apiEndPoint,
      );
      debugPrint("here is archived Data ${response.data}");
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
  Future<BaseModel> removeArchiveChat({
    required int chatId,
  }) async {
    try {
      String apiEndPoint = "${ApiKeys.chatKey}/$chatId/archive/delete";
      FormData formData = FormData();
      debugPrint("here is apiEndPoint Data $apiEndPoint");

      isError = false;
      Response response =
          await DioHelper.postData(url: apiEndPoint, data: formData);
      debugPrint("here is /archive/delete Data ${response.data}");

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

  @override
  Future<BaseModel> addArchiveChat({
    required int chatId,
  }) async {
    try {
      String apiEndPoint = "${ApiKeys.chatKey}/$chatId/archive";
      debugPrint("here is apiEndPoint Data $apiEndPoint");

      FormData formData = FormData();
      isError = false;
      Response response =
          await DioHelper.postData(url: apiEndPoint, data: formData);
      debugPrint("here is /archive Data ${response.data}");

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
