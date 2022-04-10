import 'package:default_repo_app/Data/Models/base_model.dart';
import 'package:dio/dio.dart';
import '../Network/Dio_Exception_Handling/custom_exception.dart';
import '../Network/Dio_Exception_Handling/dio_helper.dart';
import '../Network/Dio_Exception_Handling/custom_error.dart';
import '../../Interfaces/settings_interface.dart';

class SettingRepository extends SettingInterfaceRepository {
  @override
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

  @override
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
