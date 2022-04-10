import 'package:default_repo_app/Data/Models/base_model.dart';
import 'package:dio/dio.dart';
import '../Network/Dio_Exception_Handling/custom_exception.dart';
import '../Network/Dio_Exception_Handling/dio_helper.dart';
import '../Network/Dio_Exception_Handling/custom_error.dart';
import '../../Interfaces/auth_interface.dart';
class AuthRepository extends AuthRepositoryInterface  {
  /// singUp user to app
  @override
  Future<BaseModel> userSingUp(
      {required String phoneNumber,
        required String password,
        required String name,
        required String email}) async {
    isError = false;
    FormData staticData = FormData();

    try {
      staticData.fields.clear();
      String _pathUrl = '/register';
      staticData.fields.add(MapEntry('phone', phoneNumber));
      staticData.fields.add(MapEntry('password', password));
      staticData.fields.add(MapEntry('email', email));
      staticData.fields.add(MapEntry('name', name));

      Response response =
      await DioHelper.postData(url: _pathUrl, data: staticData);
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

  /// login user to app
  @override
  Future<BaseModel> loginUser({
    required String phoneNumber,
    required String password,
  }) async {
    isError = false;
    FormData staticData = FormData();

    try {
      staticData.fields.clear();
      String loginUrl = '/login';
      staticData.fields.add(MapEntry('phone', phoneNumber));
      staticData.fields.add(MapEntry('password', password));

      Response response =
      await DioHelper.postData(url: loginUrl, data: staticData);
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
  Future<BaseModel> logout() async {
    try {
      String loginUrl = '/logout';

      Response response = await DioHelper.getDate(url: loginUrl);
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
