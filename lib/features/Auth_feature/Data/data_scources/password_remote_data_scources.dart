import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Error_Handling/custom_exception.dart';

abstract class PasswordRemoteDataSourceInterface {
  ///change password
  Future<Either<CustomError, BaseModel>> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword});

  ///reset password
  Future<Either<CustomError, BaseModel>> resetPassword(
      {required String email,
      required String code,
      required String newPassword,
      required String confirmPassword});
}

class PasswordRemoteDataSourceImpl extends PasswordRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword}) async {
    try {
      FormData staticData = FormData();

      String pathUrl = ApiKeys.changePasswordKey;
      staticData.fields.add(MapEntry('new_password', newPassword));
      staticData.fields
          .add(MapEntry('new_password_confirmation', confirmPassword));
      staticData.fields.add(MapEntry('old_password', oldPassword));

      Response response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> resetPassword(
      {required String email,
      required String code,
      required String newPassword,
      required String confirmPassword}) async {
    try {
      FormData staticData = FormData();

      String pathUrl = ApiKeys.resetPasswordKey;
      staticData.fields.add(MapEntry('password', newPassword));
      staticData.fields.add(MapEntry('password_confirmation', confirmPassword));
      staticData.fields.add(MapEntry('email', email));
      staticData.fields.add(MapEntry('otp_code', code.toString()));
      Response response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }
}
