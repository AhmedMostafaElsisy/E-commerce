
import 'package:dartz/dartz.dart';

import '../../../../core/Base_interface/base_interface.dart';
import '../../../../Data/Models/base_model.dart';
import '../../../../core/Error_Handling/custom_error.dart';


abstract class OtpRepositoryInterface extends BaseInterface{

  Future<Either<CustomError, BaseModel>> verifyAccount(
      {required String email, required String code});

  Future<Either<CustomError, BaseModel>> forgetAccount({
    required String phoneNumber,
    required String code,
  });
  Future<Either<CustomError, BaseModel>> resendOTP({required String email});
}
