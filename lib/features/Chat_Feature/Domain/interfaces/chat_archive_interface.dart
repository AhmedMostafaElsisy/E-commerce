import '../../../../core/Base_interface/base_interface.dart';
import '../../../../core/model/base_model.dart';

abstract class ArchiveChatsRepositoryInterface extends BaseInterface {
  Future<BaseModel> getArchiveChats({
    required int page,
    int limit = 10,
  });

  Future<BaseModel> removeArchiveChat({
    required int chatId,
  });

  Future<BaseModel> addArchiveChat({
    required int chatId,
  });
}
