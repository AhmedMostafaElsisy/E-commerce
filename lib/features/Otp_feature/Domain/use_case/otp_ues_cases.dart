import '../repository/otp_interface.dart';
import 'package:dartz/dartz.dart';
import '../../../../Data/Models/base_model.dart';
import '../../../../core/Error_Handling/custom_error.dart';

class OtpUesCases {
  final OtpRepositoryInterface repositoryInterface;

  OtpUesCases(this.repositoryInterface);

  Future<Either<CustomError, BaseModel>> callVerifyAccount(
      {required String email, required String code}) {
    return repositoryInterface.verifyAccount(email: email, code: code);
  }

  Future<Either<CustomError, BaseModel>> callResendCode({
    required String email,
  }) {
    return repositoryInterface.resendOTP(
      email: email,
    );
  }

}
