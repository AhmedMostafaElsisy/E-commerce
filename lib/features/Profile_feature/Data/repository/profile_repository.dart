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
      {required String name, required String? phone, XFile? userImage}) {
    return remoteDataSourceInterface
        .updateProfileData(name: name, phone: phone, userImage: userImage)
        .then((value) => value.fold((l) => left(l), (r) {
              localDataSourceInterface.cacheUser(
                  user: UserBaseEntity.fromJson(r.data), token: null);
              return right(r);
            }));
  }
}
