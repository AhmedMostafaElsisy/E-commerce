
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/Base_interface/base_interface.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/model/base_model.dart';

abstract class ProfileRepositoryInterface extends BaseInterface {
  Future<Either<CustomError, BaseModel>> getUserProfile();
  Future<Either<CustomError, BaseModel>> updateUserProfile({
    required String userFirstName,
    required String userLastName,
    required String emailAddress,
    required String phoneNumber,
    required String userAddressDetails,
    required String userCity,
    required String userArea,
    XFile? userImage,
});
}
