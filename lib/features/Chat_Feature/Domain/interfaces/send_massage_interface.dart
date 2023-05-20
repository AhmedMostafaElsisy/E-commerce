import '../../../../core/Base_interface/base_interface.dart';
import '../../../../core/Constants/Enums/chat/massage_type.dart';
import '../../../../core/model/base_model.dart';

abstract class SendChatMassageInterface extends BaseInterface {
  Future<BaseModel> fetchMassageList({required int receiverId});

  Future<BaseModel> sendChatMassage(
      {required int receiverId,
      String? massageText,
      String? massageFile,
      required MassageType massageType});
}
