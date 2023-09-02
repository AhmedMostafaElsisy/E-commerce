import '../../../../core/Base_interface/base_interface.dart';
import '../../../../core/model/base_model.dart';

abstract class ChatListRepositoryInterface extends BaseInterface {
  Future<BaseModel> getChatList({
    required int page,
    int limit = 10,
  });
  Future<BaseModel> deleteChat({
    required int chatId,
  });
}
