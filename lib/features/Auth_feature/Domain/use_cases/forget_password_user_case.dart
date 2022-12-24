import 'package:dartz/dartz.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../repository/otp_interface.dart';
import '../repository/password_interface.dart';

class PasswordUesCases {
  final PasswordRepositoryInterface passwordRepositoryInterface;
  final OtpRepositoryInterface otpRepositoryInterface;

  PasswordUesCases(
      this.passwordRepositoryInterface, this.otpRepositoryInterface);

  Future<Either<CustomError, String>> callSndVerificationCodeToEmail(
      {required String email}) {
    return otpRepositoryInterface
        .sendVerificationCodeToEmail(email: email)
        .then((value) => value.fold((failure) {
              return left(failure);
            }, (success) {
              return right(success.otp!);
            }));
  }

  Future<Either<CustomError, BaseModel>> callChangeNewPassword(
      {required String email,
      required String code,
      required String password,
      required String confirmPassword}) {
    return passwordRepositoryInterface.resetPassword(
        newPassword: password,
        confirmPassword: confirmPassword,
        email: email,
        code: code);
  }

  Future<Either<CustomError, BaseModel>> callChangePassword(
      {required String oldPassword,
      required String password,
      required String confirmPassword}) {
    return passwordRepositoryInterface.changePassword(
      newPassword: password,
      confirmPassword: confirmPassword,
      oldPassword: oldPassword,
    );
  }
}
