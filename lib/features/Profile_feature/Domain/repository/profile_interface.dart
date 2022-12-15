
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/Base_interface/base_interface.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/model/base_model.dart';

abstract class ProfileRepositoryInterface extends BaseInterface {
  Future<Either<CustomError, BaseModel>> getUserProfile();
  Future<Either<CustomError, BaseModel>> updateUserProfile({
    required String name,
    required String? phone,
    XFile? userImage,
});
}
