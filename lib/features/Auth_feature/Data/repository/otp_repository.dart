import 'package:captien_omda_customer/core/model/base_model.dart';

import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

import 'package:dartz/dartz.dart';

import '../../Domain/repository/otp_interface.dart';
import '../data_scources/otp_remote_data_scources.dart';

class OtpRepository extends OtpRepositoryInterface {
  final OtpRemoteDataSourceInterface remoteDataSourceInterface;

  OtpRepository(this.remoteDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> resendOTP({required String email}) {
    return remoteDataSourceInterface.resendOTP(email: email);
  }

  @override
  Future<Either<CustomError, BaseModel>> verifyAccount(
      {required String email, required String code}) {
    return remoteDataSourceInterface.verifyAccount(email: email, code: code);
  }

  @override
  Future<Either<CustomError, BaseModel>> checkOtp(
      {required String email, required String code}) {
    return remoteDataSourceInterface.checkOtp(email: email, code: code);
  }

  @override
  Future<Either<CustomError, BaseModel>> sendVerificationCodeToEmail(
      {required String email}) {
    return remoteDataSourceInterface.sendOtp(email: email);
  }
}
