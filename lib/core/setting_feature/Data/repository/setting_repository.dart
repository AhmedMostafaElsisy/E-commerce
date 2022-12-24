import 'dart:convert';

import 'package:captien_omda_customer/core/model/base_model.dart';

import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

import 'package:dartz/dartz.dart';

import '../../Domain/repository/setting_interface.dart';
import '../data_scources/local_data_scources.dart';
import '../data_scources/remote_data_scource.dart';

class SettingRepository extends SettingRepositoryInterface {
  final SettingRemoteDataSourceInterface remoteDataSourceInterface;
  final SettingLocalDataSourceInterface localDataSourceInterface;

  SettingRepository(this.remoteDataSourceInterface,this.localDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> getSettingData() {
    return remoteDataSourceInterface.getSettingData().then((value) =>
        value.fold((failure) {
        return  localDataSourceInterface.getSettingFromCache();
        },
            (settingData) {
          localDataSourceInterface.cacheSetting(settingMap: json.encode(settingData.toJson()));
          return right(settingData);
            }));
  }
}
