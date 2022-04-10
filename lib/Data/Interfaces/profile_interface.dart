import 'package:image_picker/image_picker.dart';
import '../../Data/Models/base_model.dart';
import '../Models/user_base_model.dart';
import 'base_interface.dart';

abstract class ProfileRepositoryInterface extends BaseInterface {

  Future<BaseModel> getProfileUser();

  Future<BaseModel> updateProfile( {String? name, String? email, XFile? userImage});

  void setLocalUserData({required UserBaseModel baseUser});
}
