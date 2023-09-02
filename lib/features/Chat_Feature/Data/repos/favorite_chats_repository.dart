import 'package:dio/dio.dart';

import '../../../../core/Constants/Keys/api_keys.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';
import '../../Domain/interfaces/favorite_chat_interface.dart';

class FavoriteChatsRepository extends FavoriteChatsRepositoryInterface {
  @override
  Future<BaseModel> getFavoriteChats(
      {required int page, int limit = 10}) async {
    try {
      String apiEndPoint = '${ApiKeys.favoriteListKey}?page=$page';
      isError = false;
      Response response =
          await DioHelper.postData(url: apiEndPoint, data: FormData());

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
  Future<BaseModel> addOrRemoveFavoriteChat({
    required int chatId,
  }) async {
    try {
      String apiEndPoint = ApiKeys.addOrRemoveFavoriteUser;
      FormData formData = FormData();
      formData.fields.add(
        MapEntry("user_id", "$chatId"),
      );
      isError = false;
      Response response =
          await DioHelper.postData(url: apiEndPoint, data: formData);

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
      rethrow;
    }
  }
}
