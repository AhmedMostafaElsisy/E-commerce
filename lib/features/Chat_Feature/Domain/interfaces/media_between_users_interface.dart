import '../../../../core/Base_interface/base_interface.dart';
import '../../../../core/model/base_model.dart';

abstract class MediaBetweenUserRepositoryInterface extends BaseInterface {
  Future<BaseModel> getMediaOfUserList(
      {required int page, required int userId});
}
