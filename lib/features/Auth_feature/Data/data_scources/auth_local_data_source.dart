import 'dart:convert';
import '../../../../Data/local_source/flutter_secured_storage.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../Domain/entities/base_user_entity.dart';

abstract class AuthLocalDataSourceInterface {
  Future<void> cacheUser({required UserBaseEntity user, required String token});

  Future<void> deleteUserFromCache();
}

class AuthLocalDataSourceImp extends AuthLocalDataSourceInterface {
  final DefaultSecuredStorage flutterSecureStorage;

  AuthLocalDataSourceImp({required this.flutterSecureStorage});

  @override
  Future<void> deleteUserFromCache() async {
    await DefaultSecuredStorage.setUserMap(null);
    await DefaultSecuredStorage.setAccessToken(null);
    await DefaultSecuredStorage.setIsLogged('false');
    SharedText.userToken = "";
  }

  @override
  Future<void> cacheUser(
      {required UserBaseEntity user, required String token}) async {
    String jEncode = json.encode(user.toJson());
    SharedText.currentUser = user;
    SharedText.userToken = token;
    await DefaultSecuredStorage.setUserMap(jEncode);
    await DefaultSecuredStorage.setAccessToken(token);
    await DefaultSecuredStorage.setIsLogged('true');
  }
}
