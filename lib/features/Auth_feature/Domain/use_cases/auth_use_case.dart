import 'package:dartz/dartz.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../entities/base_user_entity.dart';
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

  Future<Either<CustomError, String>> callUserSignUp(
      {required String userFirstName,
      required String userLastName,
      required String emailAddress,
      required String phoneNumber,
      required String password,
      required String confirmPassword,
      required String userAddressDetails,
      required String userCity,
      required String userArea,
      required String token}) async {
    return await repository
        .userSingUp(
            userFirstName: userFirstName,
            userLastName: userLastName,
            emailAddress: emailAddress,
            phoneNumber: phoneNumber,
            password: password,
            confirmPassword: confirmPassword,
            userAddressDetails: userAddressDetails,
            userCity: userCity,
            userArea: userArea,
            token: token)
        .then((value) => value.fold((failure) {
              return left(failure);
            }, (success) {
              return right(
                  UserBaseEntity.fromJson(success.data["customer"]).otp!);
            }));
  }

  Future<Either<CustomError, BaseModel>> callUserLogout() async {
    return await repository.logout();
  }

  Future<Either<CustomError, BaseModel>> callUserDeleteAccount() async {
    return await repository.deleteAccount();
  }

  Future<Either<CustomError, BaseModel>> callStartApp() async {
    return await repository.startApp();
  }
}
