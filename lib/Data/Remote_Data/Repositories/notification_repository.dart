import 'package:default_repo_app/Constants/Keys/api_keys.dart';
import 'package:default_repo_app/Data/Interfaces/notification_interface.dart';
import 'package:dio/dio.dart';

import '../../Models/base_model.dart';
import '../Network/Dio_Exception_Handling/custom_error.dart';
import '../Network/Dio_Exception_Handling/custom_exception.dart';
import '../Network/Dio_Exception_Handling/dio_helper.dart';

class NotificationListRepository extends NotificationListRepositoryInterface {
  @override
  Future<BaseModel> getNotificationList({required int page}) async {
    try {
      String _notificationUrl = '${ApiKeys.notificationKey}?page=$page';
      isError = false;
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
      errorMsg = CustomError(
          type: ex.type, imgPath: ex.imgPath, errorMassage: ex.errorMassage);
      return baseModel;
    }
  }

  @override
  Future<BaseModel> clearAllNotification() async {
    try {
      String _notificationUrl =ApiKeys.notificationKey+ApiKeys.clearNotificationKey ;
      isError = false;
      FormData data = FormData();
      Response response =
          await DioHelper.postData(url: _notificationUrl, data: data);
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

  @override
  Future<BaseModel> stopOrPauseNotification({required bool state}) async {
    try {
      String _notificationUrl = ApiKeys.notificationKey+ApiKeys.toggleNotificationKey ;
      isError = false;
      FormData data = FormData();
      data.fields.add(MapEntry('status', state ? "0" : "1"));
      Response response =
          await DioHelper.postData(url: _notificationUrl, data: data);

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

  @override
  Future<BaseModel>  markNotificationAsRead(
      {required int notificationId}) async {
    try {
      String _notificationUrl =ApiKeys.notificationKey+'/$notificationId'+ApiKeys.readNotificationKey ;
      isError = false;
      FormData data = FormData();
      Response response =
          await DioHelper.postData(url: _notificationUrl, data: data);

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
}
