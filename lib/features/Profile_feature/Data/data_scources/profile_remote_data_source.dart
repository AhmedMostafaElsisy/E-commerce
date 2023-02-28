
import 'package:captien_omda_customer/core/Constants/Keys/api_keys.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/Data_source/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/model/base_model.dart';

abstract class ProfileRemoteDataSourceInterface {
  Future<Either<CustomError, BaseModel>> getProfileData();

  Future<Either<CustomError, BaseModel>> updateProfileData({
    required String userFirstName,
    required String userLastName,
    required String emailAddress,
    required String phoneNumber,
    required String userAddressDetails,
    required String userCity,
    required String userArea,
    required String locationId,
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
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> updateProfileData({
    required String userFirstName,
    required String userLastName,
    required String emailAddress,
    required String phoneNumber,
    required String userAddressDetails,
    required String userCity,
    required String userArea,
    required String locationId,
    XFile? userImage,
  }) async {
    try {
      FormData staticData = FormData();
      staticData.fields.clear();
      String pathUrl = ApiKeys.updateProfileKey;
      staticData.fields.add(MapEntry('first_name', userFirstName));
      staticData.fields.add(MapEntry('last_name', userLastName));
      staticData.fields.add(MapEntry('email', emailAddress));
      staticData.fields.add(MapEntry('phone', phoneNumber));
      staticData.fields.add(MapEntry('address', userAddressDetails));
      staticData.fields.add(MapEntry('location_id', locationId));
      staticData.fields.add(MapEntry('city', userCity));
      staticData.fields.add(MapEntry('area', userArea));
      if (userImage != null && userImage.path != "") {
        staticData.files.add(MapEntry(
            'image',
            await MultipartFile.fromFile(
              userImage.path,
              filename: userImage.path.split("/").last.toString(),
            )));
      }
      Response response =
          await DioHelper.postData(url: pathUrl, data: staticData);
      return right(BaseModel.fromJson(response.data));
    } on CustomException catch (ex) {
      return Left(CustomError(
        type: ex.error.type,
        errorMassage: ex.error.errorMassage,
      ));
    }
  }
}
