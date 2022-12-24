import 'package:captien_omda_customer/core/setting_feature/Data/model/setting_model.dart';
import 'package:dartz/dartz.dart';

import '../../../Error_Handling/custom_error.dart';
import '../../Data/repository/setting_repository.dart';
import '../repository/setting_interface.dart';

class SettingUserCase {
  final SettingRepositoryInterface repository;

  SettingUserCase({required this.repository});

  Future<Either<CustomError, SettingModel>> callAppSetting() async {
    return await repository.getSettingData().then((value) => value.fold(
        (l) => left(l),
        (settingData) => right(SettingModel.fromJson(settingData.data!))));
  }
}
