import 'dart:developer';

import 'package:captien_omda_customer/core/Constants/Keys/api_keys.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';

abstract class ProfileRemoteDataSourceInterface {
  Future<Either<CustomError, BaseModel>> getProfileData();

  Future<Either<CustomError, BaseModel>> updateProfileData({
    required String name,
    required String? phone,
    XFile? userImage,
  });
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSourceInterface {
  @override
  Future<Either<CustomError, BaseModel>> getProfileData() async {
    try {
      String url = ApiKeys.profileKey;

      Response response = await DioHelper.getDate(url: url);

      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> updateProfileData({
    required String name,
    required String? phone,
    XFile? userImage,
  }) async {
    try {
      FormData staticData = FormData();
      staticData.fields.clear();
      String pathUrl = ApiKeys.updateProfileKey;
      staticData.fields.add(MapEntry('name', name));
      if (phone != null) staticData.fields.add(MapEntry('phone', phone));

      if (userImage != null && userImage.path != "") {
        staticData.files.add(MapEntry(
            'image',
            await MultipartFile.fromFile(
              userImage.path,
              filename: userImage.path.split("/").last.toString(),
            )));
      }
      log("this the profile data ${staticData.fields}");
      Response response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }
}
