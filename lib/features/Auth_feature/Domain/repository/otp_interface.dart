
import 'package:dartz/dartz.dart';

import '../../../../core/Base_interface/base_interface.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/Error_Handling/custom_error.dart';


abstract class OtpRepositoryInterface extends BaseInterface{
  Future<Either<CustomError, BaseModel>> sendVerificationCodeToEmail(
      {required String email});

  Future<Either<CustomError, BaseModel>> verifyAccount(
      {required String email, required String code});
  Future<Either<CustomError, BaseModel>> checkOtp(
      {required String email, required String code});

  Future<Either<CustomError, BaseModel>> resendOTP({required String email});
}
