import '../Models/base_model.dart';
import 'base_interface.dart';

abstract class AuthRepositoryInterface extends BaseInterface {


  ///User Create A new Account
  Future<BaseModel> userSingUp(
      {required String phoneNumber,
      required String password,
      required String name,
      required String email});

  ///User login
  Future<BaseModel> loginUser({
    required String phoneNumber,
    required String password,
  });

  Future<BaseModel> logout();

}
