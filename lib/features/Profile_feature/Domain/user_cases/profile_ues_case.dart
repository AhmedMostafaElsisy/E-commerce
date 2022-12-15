import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../repository/profile_interface.dart';

class ProfileUesCases {
  final ProfileRepositoryInterface repositoryInterface;

  ProfileUesCases(this.repositoryInterface);

  Future<Either<CustomError, BaseModel>> callUserProfile() {
    return repositoryInterface.getUserProfile();
  }

  Future<Either<CustomError, BaseModel>> updateUserProfile(
      {required String name, required String? phone, XFile? userImage}) {
    return repositoryInterface.updateUserProfile(
        name: name, phone: phone, userImage: userImage);
  }
}
