import 'package:dio/dio.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';
import '../../domain/reposiroty/notification_interface.dart';

class NotificationListRepository extends NotificationListRepositoryInterface {
  @override
  Future<BaseModel> getNotificationList({required int page}) async {
    try {
      String notificationUrl = '${ApiKeys.notificationKey}?page=$page';
      isError = false;
      Response response = await DioHelper.getDate(url: notificationUrl);

      if (response.statusCode == 200) {
        isError = false;
        baseModel = BaseModel.fromJson(response.data);

        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg =
          CustomError(type: ex.error.type, errorMassage: ex.error.errorMassage);
      return baseModel;
    }
  }

  @override
  Future<BaseModel> clearAllNotification() async {
    try {
      String notificationUrl =
          ApiKeys.notificationKey + ApiKeys.clearNotificationKey;
      isError = false;
      FormData data = FormData();
      Response response =
          await DioHelper.postData(url: notificationUrl, data: data);
      if (response.statusCode == 200) {
        isError = false;
        baseModel = BaseModel.fromJson(response.data);

        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg =
          CustomError(type: ex.error.type, errorMassage: ex.error.errorMassage);
      return baseModel;
    }
  }

  @override
  Future<BaseModel> stopOrPauseNotification({required bool state}) async {
    try {
      String notificationUrl =
          ApiKeys.notificationKey + ApiKeys.toggleNotificationKey;
      isError = false;
      FormData data = FormData();
      data.fields.add(MapEntry('status', state ? "0" : "1"));
      Response response =
          await DioHelper.postData(url: notificationUrl, data: data);

      if (response.statusCode == 200) {
        isError = false;
        baseModel = BaseModel.fromJson(response.data);

        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg =
          CustomError(type: ex.error.type, errorMassage: ex.error.errorMassage);
      return baseModel;
    }
  }

  @override
  Future<BaseModel> markNotificationAsRead(
      {required int notificationId}) async {
    try {
      String notificationUrl =
          '${ApiKeys.notificationKey}/$notificationId${ApiKeys.readNotificationKey}';
      isError = false;
      FormData data = FormData();
      Response response =
          await DioHelper.postData(url: notificationUrl, data: data);

      if (response.statusCode == 200) {
        isError = false;
        baseModel = BaseModel.fromJson(response.data);

        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg =
          CustomError(type: ex.error.type, errorMassage: ex.error.errorMassage);
      return baseModel;
    }
  }
}
