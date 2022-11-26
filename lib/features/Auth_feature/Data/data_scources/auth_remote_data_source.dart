import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../Data/Remote_Data/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';

abstract class AuthRemoteDataSourceInterface {
  Future<Either<CustomError, Response>> loginUser(
      {required String email, required String password, required String token});

  Future<Either<CustomError, Response>> logOut();
}

class AuthRemoteDataSourceImp extends AuthRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, Response>> logOut() async {
    FormData staticData = FormData();
    try {
      staticData.fields.clear();
      String loginUrl = ApiKeys.logOutKey;

      Response response = await DioHelper.getDate(url: loginUrl);

      DioHelper.dio.options.headers.remove("Authorization");

      return Right(response);
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, Response>> loginUser(
      {required String email,
      required String password,
      required String token}) async {
    FormData staticData = FormData();
    try {
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

      return Right(response);
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }
}
