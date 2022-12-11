import 'package:captien_omda_customer/features/Auth_feature/Data/model/base_user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Data/Models/base_model.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../repository/auth_interface.dart';

class AuthUserCase {
  final AuthRepositoryInterface repository;

  AuthUserCase({required this.repository});

  Future<Either<CustomError, BaseModel>> callUserLogin({
    required String email,
    required String password,
    required String deviceToken,
  }) async {
    return await repository.loginUser(
        email: email, password: password, token: deviceToken);
  }

  Future<Either<CustomError, BaseModel>> callUserSignUp(
      {required String userName,
      required String emailAddress,
      required String phoneNumber,
      required String password,
      required String confirmPassword,
      XFile? userImage,
      required String token}) async {
    return await repository.userSingUp(
        userName: userName,
        phoneNumber: phoneNumber,
        confirmPassword: confirmPassword,
        userImage: userImage,
        emailAddress: emailAddress,
        password: password,
        token: token);
  }

  Future<Either<CustomError, BaseModel>> callUserLogout() async {
    return await repository.logout();
  }

  Future<Either<CustomError, BaseModel>> callStartApp() async {
    return await repository.startApp();
  }
}
