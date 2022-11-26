import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:default_repo_app/Data/Models/base_model.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Data/local_source/flutter_secured_storage.dart';
import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../Data/Remote_Data/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../Domain/entities/base_user_entity.dart';
import '../../Domain/repository/auth_interface.dart';
import '../data_scources/auth_local_data_source.dart';
import '../data_scources/auth_remote_data_source.dart';

class AuthRepository extends AuthRepositoryInterface {
  final AuthLocalDataSourceInterface localDataSourceInterface;
  final AuthRemoteDataSourceInterface remoteDataSourceInterface;

  AuthRepository(
      {required this.localDataSourceInterface,
      required this.remoteDataSourceInterface});

  /// singUp user to app
  @override
  Future<BaseModel> userSingUp(
      {required String userName,
      required String emailAddress,
      required String phoneNumber,
      required String password,
      required String confirmPassword,
      XFile? userImage,
      required String token}) async {
    isError = false;
    FormData staticData = FormData();

    try {
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
  Future<Either<CustomError, BaseModel>> loginUser(
      {required String email,
      required String password,
      required String token}) async {
    FormData staticData = FormData();
    try {
      ///Todo: what to do here
      // var remoteResult = await remoteDataSourceInterface.loginUser(
      //     email: email, password: password, token: token);
      //
      // remoteResult.fold((failure) {
      //   return left(failure);
      // }, (success) {});
      staticData.fields.clear();
      String loginUrl = ApiKeys.loginKey;
      staticData.fields.add(MapEntry('email', email));
      staticData.fields.add(MapEntry('password', password));
      staticData.fields.add(MapEntry('device_token', token));

      Response response =
          await DioHelper.postData(url: loginUrl, data: staticData);

      /// parsing response to user model
      baseModel = BaseModel.fromJson(response.data);

      ///save user token and cash your data
      DioHelper.dio.options.headers
          .addAll({"Authorization": "Bearer ${baseModel.data['token']}"});
      UserBaseEntity userModel =
          UserBaseEntity.fromJson(baseModel.data["customer"]);
      String jEncode = json.encode(userModel.toJson());

      await DefaultSecuredStorage.setUserMap(jEncode);
      await DefaultSecuredStorage.setAccessToken(baseModel.data['token']);
      await DefaultSecuredStorage.setIsLogged('true');
      SharedText.userToken = baseModel.data['token'];
      SharedText.currentUser = userModel;
      return Right(baseModel);
    } on CustomException catch (ex) {
      errorMsg = CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath);
      return Left(errorMsg!);
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> logout() async {
    try {
      String loginUrl = ApiKeys.logOutKey;

      Response response = await DioHelper.getDate(url: loginUrl);
      if (response.statusCode == 200) {
        /// parsing response to user model
        baseModel = BaseModel.fromJson(response.data);
        await DefaultSecuredStorage.setUserMap(null);
        await DefaultSecuredStorage.setAccessToken(null);
        await DefaultSecuredStorage.setIsLogged('false');
        SharedText.userToken = "";
        DioHelper.dio.options.headers.remove("Authorization");

        return Right(baseModel);
      } else {
        return Right(baseModel);
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg = CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath);
      return Left(errorMsg!);
    }
  }
}
