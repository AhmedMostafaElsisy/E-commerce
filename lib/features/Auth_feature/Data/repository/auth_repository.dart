import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Data/Models/base_model.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../Domain/entities/base_user_entity.dart';
import '../../Domain/repository/auth_interface.dart';
import '../data_scources/auth_local_data_source.dart';
import '../data_scources/auth_remote_data_source.dart';

class AuthRepository extends AuthRepositoryInterface {
  final AuthLocalDataSourceInterface localDataSourceInterface;
  final AuthRemoteDataSourceInterface remoteDataSourceInterface;

  AuthRepository(
      {required this.localDataSourceInterface,
      required this.remoteDataSourceInterface});

  /// singUp user to app
  @override
  Future<Either<CustomError, BaseModel>> userSingUp(
      {required String userName,
      required String emailAddress,
      required String phoneNumber,
      required String password,
      required String confirmPassword,
      XFile? userImage,
      required String token}) async {
    return  await remoteDataSourceInterface.userSingUp(
        confirmPassword: confirmPassword,
        phoneNumber: phoneNumber,
        userName: userName,
        userImage: userImage,
        emailAddress: emailAddress,
        password: password,
        token: token);
  }

  /// login user to app
  @override
  Future<Either<CustomError, BaseModel>> loginUser(
      {required String email,
      required String password,
      required String token}) async {
    ///login user in remote data source
    return await remoteDataSourceInterface
        .loginUser(email: email, password: password, token: token)
        .then((value) => value.fold((failure) {
              return left(failure);
            }, (success) {
              ///save the user model in cache
              localDataSourceInterface.cacheUser(
                  user: UserBaseEntity.fromJson(success.data["customer"]),
                  token: success.data["token"]);
              return right(success);
            }));
  }

  @override
  Future<Either<CustomError, BaseModel>> logout() async {
    try {
      ///logout user in remote data source
      var baseModel = await remoteDataSourceInterface.logOut();

      ///remove the user model from cache
      localDataSourceInterface.deleteUserFromCache();

      ///return the right side of either (base model)
      return right(baseModel);
    } on CustomException catch (ex) {
      errorMsg = CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath);
      return Left(errorMsg!);
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> startApp() {

    return localDataSourceInterface
        .checkUserLoginCache()
        .then((value) => value.fold((failure) {
              return left(failure);
            }, (token) {
              remoteDataSourceInterface.saveAuthToken(token: token);
              SharedText.userToken = token;
              return right(BaseModel());
            }));
  }
}
