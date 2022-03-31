
import 'package:default_repo_app/Data/Models/base_model.dart';
import 'package:default_repo_app/Data/Network/Dio_Exception_Handling/custom_error.dart';
import 'package:default_repo_app/Data/Network/Dio_Exception_Handling/custom_exception.dart';
import 'package:default_repo_app/Data/Network/Dio_Exception_Handling/dio_helper.dart';
import 'package:dio/dio.dart';

class SettingRepository {
  BaseModel baseModel = BaseModel();
  CustomError? errorMsg;
  bool isError = false;

  Future<BaseModel> getTermsAndConditions() async {
    isError = false;

    try {
      String _pathUrl = '/terms';

      Response response = await DioHelper.getDate(
        url: _pathUrl,
      );
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

  Future<BaseModel> getFqa() async {
    isError = false;

    try {
      String _pathUrl = '/faqs';

      Response response = await DioHelper.getDate(
        url: _pathUrl,
      );
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
}
