import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Data/Models/base_model.dart';
import '../../../../Data/Remote_Data/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';

abstract class AuthRemoteDataSourceInterface {
  Future<Either<CustomError, BaseModel>> loginUser(
      {required String email, required String password, required String token});

  Future<BaseModel> logOut();

  ///User Create A new Account
  Future<BaseModel> userSingUp(
      {required String userName,
      required String emailAddress,
      required String phoneNumber,
      required String password,
      required String confirmPassword,
      XFile? userImage,
      required String token});
}

class AuthRemoteDataSourceImp extends AuthRemoteDataSourceInterface {
  @override
  Future<BaseModel> logOut() async {
    FormData staticData = FormData();

    staticData.fields.clear();
    String loginUrl = ApiKeys.logOutKey;

    Response response = await DioHelper.getDate(url: loginUrl);

    DioHelper.dio.options.headers.remove("Authorization");

    return BaseModel.fromJson(response.data);
  }

  @override
  Future<Either<CustomError, BaseModel>> loginUser(
      {required String email,
      required String password,
      required String token}) async {
    try {
      FormData staticData = FormData();
      staticData.fields.clear();
      String loginUrl = ApiKeys.loginKey;
      staticData.fields.add(MapEntry('email', email));
      staticData.fields.add(MapEntry('password', password));
      staticData.fields.add(MapEntry('device_token', token));

      Response response =
          await DioHelper.postData(url: loginUrl, data: staticData);

      ///save user token and cash your data
      DioHelper.dio.options.headers
          .addAll({"Authorization": "Bearer ${response.data['token']}"});
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<BaseModel> userSingUp(
      {required String userName,
      required String emailAddress,
      required String phoneNumber,
      required String password,
      required String confirmPassword,
      XFile? userImage,
      required String token}) async {
    FormData staticData = FormData();
    staticData.fields.clear();
    String _pathUrl = ApiKeys.singUpKey;
    staticData.fields.add(MapEntry('name', userName));
    staticData.fields.add(MapEntry('email', emailAddress));
    staticData.fields.add(MapEntry('phone', phoneNumber));
    staticData.fields.add(MapEntry('password', password));
    staticData.fields.add(MapEntry('password_confirmation', confirmPassword));
    staticData.fields.add(MapEntry('device_token', token));

    Response response =
        await DioHelper.postData(url: _pathUrl, data: staticData);

    return BaseModel.fromJson(response.data);
  }
}
