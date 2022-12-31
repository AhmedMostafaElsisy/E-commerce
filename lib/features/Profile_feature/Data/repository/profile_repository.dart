import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

import 'package:captien_omda_customer/core/model/base_model.dart';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Auth_feature/Data/data_scources/auth_local_data_source.dart';
import '../../../Auth_feature/Domain/entities/base_user_entity.dart';
import '../../Domain/repository/profile_interface.dart';
import '../data_scources/profile_remote_data_source.dart';

class ProfileRepository extends ProfileRepositoryInterface {
  final ProfileRemoteDataSourceInterface remoteDataSourceInterface;
  final AuthLocalDataSourceInterface localDataSourceInterface;

  ProfileRepository(
      this.remoteDataSourceInterface, this.localDataSourceInterface);

  @override
  Future<Either<CustomError, BaseModel>> getUserProfile() {
    return remoteDataSourceInterface.getProfileData();
  }

  @override
  Future<Either<CustomError, BaseModel>> updateUserProfile(
      {required String userFirstName,
      required String userLastName,
      required String emailAddress,
      required String phoneNumber,
      required String userAddressDetails,
      required String userCity,
      required String userArea,
      XFile? userImage}) {
    return remoteDataSourceInterface
        .updateProfileData(
            userFirstName: userFirstName,
            userLastName: userLastName,
            emailAddress: emailAddress,
            phoneNumber: phoneNumber,
            userAddressDetails: userAddressDetails,
            userCity: userCity,
            userArea: userArea,
            userImage: userImage)
        .then((value) => value.fold((l) => left(l), (r) {
              localDataSourceInterface.cacheUser(
                  user: UserBaseEntity.fromJson(r.data), token: null);
              return right(r);
            }));
  }
}
