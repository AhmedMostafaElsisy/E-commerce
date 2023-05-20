import '../../../../core/Base_interface/base_interface.dart';
import '../../../../core/model/base_model.dart';

abstract class ChatRealTimeRepositoryInterface extends BaseInterface {
  Future<BaseModel> authYouOnChat({
    required String socketId,
  });
}
