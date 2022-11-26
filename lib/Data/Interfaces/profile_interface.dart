import 'package:image_picker/image_picker.dart';
import '../../Data/Models/base_model.dart';
import '../../features/Auth_feature/Domain/entities/base_user_entity.dart';
import '../../core/Base_interface/base_interface.dart';

abstract class ProfileRepositoryInterface extends BaseInterface {

  Future<BaseModel> getProfileUser();

  Future<BaseModel> updateProfile( {String? name, String? email, XFile? userImage});

  void setLocalUserData({required UserBaseEntity baseUser});
}
