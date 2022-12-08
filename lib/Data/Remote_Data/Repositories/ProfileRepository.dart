import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/Helpers/shared_texts.dart';
import '../../Interfaces/profile_interface.dart';
import '../../Models/base_model.dart';
import '../../../features/Auth_feature/Domain/entities/base_user_entity.dart';
import '../../local_source/flutter_secured_storage.dart';
import '../../../core/Error_Handling/custom_error.dart';
import '../../../core/Error_Handling/custom_exception.dart';
import '../Network/Dio_Exception_Handling/dio_helper.dart';

class ProfileRepository extends ProfileRepositoryInterface  {
  ///auth user Profile_Cubit data
  @override
  Future<BaseModel> getProfileUser() async {
    try {
      String _profileUrl = '/me';
      isError = false;
      Response response = await DioHelper.getDate(url: _profileUrl);

      if (response.statusCode == 200) {
        isError = false;
        baseModel = BaseModel.fromJson(response.data);

        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg = CustomError(
          type: ex.type, imgPath: ex.imgPath, errorMassage: ex.errorMassage);
      return baseModel;
    }
  }

  ///update auth user Profile_Cubit data
  @override
  Future<BaseModel> updateProfile(
      {String? name, String? email, XFile? userImage}) async {
    try {
      String _profileUrl = '/update/profile';
      isError = false;
      FormData staticData = FormData();
      staticData.fields.clear();

      if (name != null) {
        staticData.fields.add(MapEntry('name', name));
      }
      if (email != null) {
        staticData.fields.add(MapEntry('email', email));
      }
      if (userImage != null) {
        staticData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(
            userImage.path,
            filename: userImage.path.split("/").last.toString(),
          ),
        ));
        debugPrint('fields data ${staticData.files.toString()}');
      }
      Response response =
          await DioHelper.postData(url: _profileUrl, data: staticData);

      if (response.statusCode == 200) {
        isError = false;
        debugPrint('response of Profile_Cubit data ${response.data}');
        baseModel = BaseModel.fromJson(response.data);

        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg = CustomError(
          type: ex.type, imgPath: ex.imgPath, errorMassage: ex.errorMassage);
      return baseModel;
    }
  }

  ///Update local user map
  @override
  void setLocalUserData({required UserBaseEntity baseUser}) async {
    String jEncode = json.encode(baseUser.toJson());

    await DefaultSecuredStorage.setUserMap(jEncode);

    await DefaultSecuredStorage.setIsLogged('true');

    SharedText.currentUser = baseUser;
  }


}
