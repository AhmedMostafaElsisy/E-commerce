import 'package:dartz/dartz.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../Domain/repository/password_interface.dart';
import '../data_scources/password_remote_data_scources.dart';

class PasswordRepository extends PasswordRepositoryInterface {
  final PasswordRemoteDataSourceInterface remoteDataSourceInterface;

  PasswordRepository(this.remoteDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword}) async {
    return remoteDataSourceInterface.changePassword(
        confirmPassword: confirmPassword,
        newPassword: newPassword,
        oldPassword: oldPassword);
  }

  @override
  Future<Either<CustomError, BaseModel>> resetPassword(
      {required String email,
      required String code,
      required String newPassword,
      required String confirmPassword}) async {
    return remoteDataSourceInterface.resetPassword(
        email: email,
        code: code,
        newPassword: newPassword,
        confirmPassword: confirmPassword);
  }
}
