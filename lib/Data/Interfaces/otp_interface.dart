import 'package:default_repo_app/Data/Models/base_model.dart';

import 'base_interface.dart';


abstract class OtpRepositoryInterface extends BaseInterface{

  Future<BaseModel> verifyAccount(
      {required String email, required String code});

  Future<BaseModel> forgetAccount({
    required String phoneNumber,
    required String code,
  });
  Future<BaseModel> resendOTP({required String email});
}
