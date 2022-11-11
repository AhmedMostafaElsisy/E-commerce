import 'package:image_picker/image_picker.dart';

import '../Models/base_model.dart';
import 'base_interface.dart';

abstract class AuthRepositoryInterface extends BaseInterface {


  ///User Create A new Account
  Future<BaseModel> userSingUp(
      {
        required String userName,
        required String emailAddress,
        required String phoneNumber,
        required String password,
        required String confirmPassword,
        XFile? userImage,
        required String token

      });

  ///User login
  Future<BaseModel> loginUser({
    required String email,
    required String password,
    required String token

  });

  Future<BaseModel> logout();

}
