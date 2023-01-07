import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';
//todo:need to handel it with cc talks about exceptions

abstract class AuthRemoteDataSourceInterface {
  ///login user
  Future<Either<CustomError, BaseModel>> loginUser(
      {required String email, required String password, required String token});

  ///log out
  Future<BaseModel> logOut();

  ///log out
  Future<Either<CustomError, BaseModel>> deleteAccount();

  ///User Create A new Account
  Future<Either<CustomError, BaseModel>> userSingUp(
      {required String userFirstName,
      required String userLastName,
      required String emailAddress,
      required String phoneNumber,
      required String password,
      required String confirmPassword,
      required String userAddressDetails,
      required String userCity,
      required String userArea,
      required String token});

  void saveAuthToken({required String token});

  void deleteAuthToken();
}

class AuthRemoteDataSourceImp extends AuthRemoteDataSourceInterface {
  @override
  Future<BaseModel> logOut() async {
    FormData staticData = FormData();

    staticData.fields.clear();
    String loginUrl = ApiKeys.logOutKey;

    Response response =
        await DioHelper.postData(url: loginUrl, data: FormData());

    ///delete user token from Auth header
    deleteAuthToken();

    return BaseModel.fromJson(response.data);
  }

  @override
  Future<Either<CustomError, BaseModel>> deleteAccount() async {
    try {
      FormData staticData = FormData();

      staticData.fields.clear();
      String loginUrl = ApiKeys.deleteProfileKey;

      Response response =
          await DioHelper.postData(url: loginUrl, data: FormData());

      ///delete user token from Auth header
      deleteAuthToken();

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
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
      saveAuthToken(token: response.data["data"]['token']);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> userSingUp(
      {required String userFirstName,
      required String userLastName,
      required String emailAddress,
      required String phoneNumber,
      required String password,
      required String confirmPassword,
      required String userAddressDetails,
      required String userCity,
      required String userArea,
      required String token}) async {
    try {
      FormData staticData = FormData();
      staticData.fields.clear();
      String pathUrl = ApiKeys.singUpKey;
      staticData.fields.add(MapEntry('first_name', userFirstName));
      staticData.fields.add(MapEntry('last_name', userLastName));
      staticData.fields.add(MapEntry('email', emailAddress));
      staticData.fields.add(MapEntry('phone', phoneNumber));
      staticData.fields.add(MapEntry('password', password));
      staticData.fields.add(MapEntry('password_confirmation', confirmPassword));
      staticData.fields.add(MapEntry('address', userAddressDetails));
      staticData.fields.add(MapEntry('city', userCity));
      staticData.fields.add(MapEntry('area', userArea));
      staticData.fields.add(MapEntry('device_token', token));
      Response response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
  }

  @override
  void deleteAuthToken() {
    DioHelper.dio.options.headers.remove("Authorization");
  }

  @override
  void saveAuthToken({required String token}) {
    DioHelper.dio.options.headers.addAll({"Authorization": "Bearer $token"});
  }
}
