import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/Base_interface/base_interface.dart';
import '../../../../core/Error_Handling/custom_error.dart';

abstract class AuthRepositoryInterface extends BaseInterface {


  ///User Create A new Account
  Future<Either<CustomError, BaseModel>> userSingUp(
      {required String userFirstName,
        required String userLastName,
        required String emailAddress,
        required String phoneNumber,
        required String password,
        required String confirmPassword,
        required String userAddressDetails,
        required String userCity,
        required String userArea,
        required String token});

  ///User login
  Future<Either<CustomError, BaseModel>> loginUser({
    required String email,
    required String password,
    required String token

  });

  Future<Either<CustomError, BaseModel>> logout();
  Future<Either<CustomError, BaseModel>> deleteAccount();
  Future<Either<CustomError, BaseModel>> startApp();

}
