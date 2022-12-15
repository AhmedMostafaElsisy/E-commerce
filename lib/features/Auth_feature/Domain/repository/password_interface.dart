import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/Base_interface/base_interface.dart';
import '../../../../core/Error_Handling/custom_error.dart';

abstract class PasswordRepositoryInterface extends BaseInterface {
  Future<Either<CustomError, BaseModel>> resetPassword(
      {required String email,
      required String newPassword,
        required String code,
      required String confirmPassword});

  Future<Either<CustomError, BaseModel>> changePassword(
      {required String oldPassword,

      required String newPassword,
      required String confirmPassword});
}
