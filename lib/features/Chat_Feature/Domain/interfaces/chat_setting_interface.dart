import '../../../../core/Base_interface/base_interface.dart';
import '../../../../core/model/base_model.dart';

abstract class ChatSettingInterface extends BaseInterface {
  Future<BaseModel> getChatSettingData();

  Future<BaseModel> changeSettingValue(
      {required String settingKey, required bool settingValue});
}
