import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';
import '../../Domain/interfaces/media_between_users_interface.dart';

class MediaBetweenUserRepository extends MediaBetweenUserRepositoryInterface {
  @override
  Future<BaseModel> getMediaOfUserList(
      {required int page, required int userId}) async {
    try {
      String _notificationUrl = '${ApiKeys.chatMediaKey}/$userId';
      isError = false;
      debugPrint("_notificationUrl: $_notificationUrl");
      Response response = await DioHelper.getDate(url: _notificationUrl);

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
}
