import 'package:dio/dio.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';
import '../../Domain/interfaces/chat_setting_interface.dart';

class ChatSettingRepo extends ChatSettingInterface {
  @override
  Future<BaseModel> getChatSettingData() async {
    try {
      String apiEndPoint = ApiKeys.chatSettingKey;
      isError = false;
      Response response = await DioHelper.getDate(url: apiEndPoint);

      if (response.statusCode == 200) {
        isError = false;
        baseModel = BaseModel.fromJson(response.data);

        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg = ex.error;
      return baseModel;
    }
  }

  @override
  Future<BaseModel> changeSettingValue(
      {required String settingKey, required bool settingValue}) async {
    try {
      String apiEndPoint = ApiKeys.chatValueSettingKey;
      isError = false;
      Map<String, dynamic> chatSetting = {};
      List<String> keyList = [];
      List<int> valueList = [];
      valueList.add(settingValue ? 0 : 1);
      keyList.add(settingKey);
      chatSetting = {
        "key": keyList,
        "status": valueList,
      };
      FormData staticData = FormData.fromMap(
        chatSetting,
        ListFormat.multiCompatible,
      );
      Response response =
          await DioHelper.postData(url: apiEndPoint, data: staticData);
      print("response data ${response.data}");
      if (response.statusCode == 200) {
        isError = false;
        baseModel = BaseModel.fromJson(response.data);

        return baseModel;
      } else {
        isError = true;
        baseModel = BaseModel.fromJson(response.data);
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;

      errorMsg = ex.error;
      return baseModel;
    }
  }
}
