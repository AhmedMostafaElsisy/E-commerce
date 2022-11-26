import 'package:dartz/dartz.dart';
import '../../../../Data/Models/base_model.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../repository/auth_interface.dart';

class LoginUesCase {
  final AuthRepositoryInterface repository;

  LoginUesCase({required this.repository});

  Future<Either<CustomError, BaseModel>> callUserLogin({
    required String email,
    required String password,
    required String deviceToken,
  }) async {
    return await repository.loginUser(
        email: email, password: password, token: deviceToken);
  }

  Future<Either<CustomError, BaseModel>> callUserLogout() async {
    return await repository.logout();
  }
}
