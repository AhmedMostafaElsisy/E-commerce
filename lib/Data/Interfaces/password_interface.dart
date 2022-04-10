import '../Models/base_model.dart';
import 'base_interface.dart';

abstract class PasswordRepositoryInterface extends BaseInterface{


  Future<BaseModel> changePassword(  {required String currentPassword,
    required String newPassword,
    required String confirmPassword});

  Future<BaseModel> forgetPassword({required String phoneNumber});
}
