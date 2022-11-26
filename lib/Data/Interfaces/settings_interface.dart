import 'package:dartz/dartz.dart';
import 'package:default_repo_app/Data/Models/base_model.dart';

import '../../core/Error_Handling/custom_error.dart';
import '../../core/Base_interface/base_interface.dart';

abstract class SettingInterfaceRepository extends BaseInterface {
  Future<BaseModel> getFqa();

  Future<Either<CustomError, BaseModel>> getTermsAndConditions();
}
