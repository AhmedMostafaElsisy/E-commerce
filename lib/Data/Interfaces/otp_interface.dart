
import '../../core/Base_interface/base_interface.dart';
import '../Models/base_model.dart';


abstract class OtpRepositoryInterface extends BaseInterface{

  Future<BaseModel> verifyAccount(
      {required String email, required String code});

  Future<BaseModel> forgetAccount({
    required String phoneNumber,
    required String code,
  });
  Future<BaseModel> resendOTP({required String email});
}
