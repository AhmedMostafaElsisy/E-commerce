import 'dart:convert';

import 'package:captien_omda_customer/core/Constants/Enums/exception_enums.dart';
import 'package:dartz/dartz.dart';

import '../../../Data_source/local_source/flutter_secured_storage.dart';
import '../../../Error_Handling/custom_error.dart';
import '../../../model/base_model.dart';

abstract class SettingLocalDataSourceInterface {
  Future<void> cacheSetting({required String settingMap});

  Future<Either<CustomError, BaseModel>> getSettingFromCache();
}

class SettingLocalDataSourceImp extends SettingLocalDataSourceInterface {
  final DefaultSecuredStorage flutterSecureStorage;

  SettingLocalDataSourceImp({required this.flutterSecureStorage});

  @override
  Future<void> cacheSetting({required String settingMap}) async {
    await DefaultSecuredStorage.setSettingMap(settingMap);
  }

  @override
  Future<Either<CustomError, BaseModel>> getSettingFromCache() async {
    try {
      String? settingModel = await DefaultSecuredStorage.getSetting();

      return right(BaseModel.fromJson(json.decode(settingModel!)));
    } catch (e) {
      return left(CustomError(
          errorMassage: e.toString(),
          type: CustomStatusCodeErrorType.unExcepted));
    }
  }
}
