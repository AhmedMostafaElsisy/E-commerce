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
      {required String userFirstName,
      required String userLastName,
      required String emailAddress,
      required String phoneNumber,
      required String userAddressDetails,
      required String userCity,
      required String userArea,
      required String locationId,
      XFile? userImage}) {
    return repositoryInterface.updateUserProfile(
        userFirstName: userFirstName,
        userLastName: userLastName,
        emailAddress: emailAddress,
        phoneNumber: phoneNumber,
        userAddressDetails: userAddressDetails,
        userCity: userCity,
        userArea: userArea,
        locationId: locationId,
        userImage: userImage);
  }
}
