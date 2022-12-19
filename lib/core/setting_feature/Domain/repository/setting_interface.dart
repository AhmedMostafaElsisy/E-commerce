
import 'package:dartz/dartz.dart';

import '../../../Base_interface/base_interface.dart';
import '../../../Error_Handling/custom_error.dart';
import '../../../model/base_model.dart';

abstract class SettingRepositoryInterface extends BaseInterface {
  Future<Either<CustomError, BaseModel>> getSettingData();
}