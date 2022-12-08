import 'package:dartz/dartz.dart';

import '../../core/Error_Handling/custom_error.dart';
import '../../core/Base_interface/base_interface.dart';
import '../Models/base_model.dart';

abstract class SettingInterfaceRepository extends BaseInterface {
  Future<BaseModel> getFqa();

  Future<Either<CustomError, BaseModel>> getTermsAndConditions();
}
