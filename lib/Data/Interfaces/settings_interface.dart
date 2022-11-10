import 'package:dartz/dartz.dart';
import 'package:default_repo_app/Data/Models/base_model.dart';

import '../Remote_Data/Network/Dio_Exception_Handling/custom_error.dart';
import 'base_interface.dart';

abstract class SettingInterfaceRepository extends BaseInterface {
  Future<BaseModel> getFqa();

  Future<Either<CustomError, BaseModel>> getTermsAndConditions();
}
