import '../Models/base_model.dart';
import '../../core/Base_interface/base_interface.dart';

abstract class PasswordRepositoryInterface extends BaseInterface {
  Future<BaseModel> sendVerificationCodeToEmail({required String email});

  Future<BaseModel> resetPassword(
      {required String email,
        required String newPassword,
        required String confirmPassword});

  Future<BaseModel> changePassword(
      {required String oldPassword,required String newPassword, required String confirmPassword});
}
