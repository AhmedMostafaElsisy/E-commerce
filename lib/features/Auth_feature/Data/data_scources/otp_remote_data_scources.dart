import 'package:captien_omda_customer/core/Constants/Keys/api_keys.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';

abstract class OtpRemoteDataSourceInterface {
  ///verify account
  Future<Either<CustomError, BaseModel>> verifyAccount(
      {required String email, required String code});

  ///check otp
  Future<Either<CustomError, BaseModel>> checkOtp(
      {required String email, required String code});

  ///send otp to email
  Future<Either<CustomError, BaseModel>> sendOtp(
      {required String email});

  ///resend otp
  Future<Either<CustomError, BaseModel>> resendOTP({
    required String email,
  });
}

class OtpRemoteDataSourceImp extends OtpRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> resendOTP(
      {required String email}) async {
    try {
      FormData staticData = FormData();

      String pathUrl = ApiKeys.reSendOtpKey;
      staticData.fields.add(MapEntry('email', email));

      Response response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> verifyAccount(
      {required String email, required String code}) async {
    try {
      FormData staticData = FormData();

      String pathUrl = ApiKeys.checkAndVerifyKey;
      staticData.fields.add(MapEntry('email', email));
      staticData.fields.add(MapEntry('otp', code));

      Response response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> checkOtp(
      {required String email, required String code}) async {
    try {
      FormData staticData = FormData();

      String pathUrl = ApiKeys.checkOtpKey;
      staticData.fields.add(MapEntry('email', email));
      staticData.fields.add(MapEntry('otp_code', code));

      Response response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> sendOtp(
      {required String email})  async {
    try {
      FormData staticData = FormData();

      String pathUrl = ApiKeys.forgetPasswordKey;
      staticData.fields.add(MapEntry('email', email));

      Response response =
      await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }
}
