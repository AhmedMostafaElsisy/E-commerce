import '../repository/otp_interface.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/Error_Handling/custom_error.dart';

class OtpUesCases {
  final OtpRepositoryInterface repositoryInterface;

  OtpUesCases(this.repositoryInterface);

  Future<Either<CustomError, BaseModel>> callVerifyAccount(
      {required String email, required String code}) {
    return repositoryInterface.verifyAccount(email: email, code: code);
  }

  Future<Either<CustomError, String>> callResendCode({
    required String email,
  }) {
    return repositoryInterface
        .resendOTP(
          email: email,
        )
        .then((value) => value.fold((failure) {
              return left(failure);
            }, (success) {
              return right(success.data["otp"].toString());
            }));
  }

  Future<Either<CustomError, BaseModel>> callCheckOtp({
    required String email,
    required String code,
  }) {
    return repositoryInterface.checkOtp(email: email, code: code);
  }
}
