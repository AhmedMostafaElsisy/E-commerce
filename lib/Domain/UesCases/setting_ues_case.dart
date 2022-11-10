import 'package:dartz/dartz.dart';
import 'package:default_repo_app/Data/Interfaces/settings_interface.dart';
import 'package:default_repo_app/Data/Models/base_model.dart';
import 'package:default_repo_app/Data/Remote_Data/Network/Dio_Exception_Handling/custom_error.dart';

class SettingUesCase {
  final SettingInterfaceRepository repository;

  SettingUesCase({required this.repository});
  Future<Either<CustomError, BaseModel>> call() async {
    return await repository.getTermsAndConditions();
  }
}
