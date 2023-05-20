import '../../../../core/Base_interface/base_interface.dart';
import '../../../../core/model/base_model.dart';

abstract class FavoriteChatsRepositoryInterface extends BaseInterface {
  Future<BaseModel> getFavoriteChats({
    required int page,
    int limit = 10,
  });
  Future<BaseModel> addOrRemoveFavoriteChat({
    required int chatId,
  });
}
