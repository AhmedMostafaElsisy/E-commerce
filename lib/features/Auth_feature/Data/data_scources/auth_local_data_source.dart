import 'dart:convert';

import 'package:captien_omda_customer/core/Constants/Enums/exception_enums.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/Data_source/local_source/flutter_secured_storage.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../Domain/entities/base_user_entity.dart';

abstract class AuthLocalDataSourceInterface {
  Future<void> cacheUser(
      {required UserBaseEntity user, required String? token});

  Future<void> deleteUserFromCache();

  Future<Either<CustomError, String>> checkUserLoginCache();
}

class AuthLocalDataSourceImp extends AuthLocalDataSourceInterface {
  final DefaultSecuredStorage flutterSecureStorage;

  AuthLocalDataSourceImp({required this.flutterSecureStorage});

  @override
  Future<void> deleteUserFromCache() async {
    await DefaultSecuredStorage.removeUserMapFromCache();
    await DefaultSecuredStorage.removeAccessTokenFromCache();
    await DefaultSecuredStorage.setIsLogged('false');
    SharedText.userToken = "";
  }

  @override
  Future<void> cacheUser(
      {required UserBaseEntity user, required String? token}) async {
    String jEncode = json.encode(user.toJson());
    SharedText.currentUser = user;
    if (token != null) {
      SharedText.userToken = token;
      await DefaultSecuredStorage.setAccessToken(token);
    }

    await DefaultSecuredStorage.setUserMap(jEncode);
    await DefaultSecuredStorage.setIsLogged('true');
  }

  @override
  Future<Either<CustomError, String>> checkUserLoginCache() async {
    var result = await DefaultSecuredStorage.getIsLogged() ?? 'false';

    debugPrint("auth result is $result");

    if (result == 'true') {
      await _updateUserDataFromLocalCached();

      String? token = await DefaultSecuredStorage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        debugPrint("here is token $token");
        return right(token);
      } else {
        return left(CustomError(
            errorMassage: "failed to get user from cached",
            type: CustomStatusCodeErrorType.unExcepted));
      }
    } else {
      return left(CustomError(
          errorMassage: "failed to get user from cached",
          type: CustomStatusCodeErrorType.unExcepted));
    }
  }

  _updateUserDataFromLocalCached() async {
    final userString = await DefaultSecuredStorage.getUserMap();
    final baseUserMap = json.decode(userString!);
    UserBaseEntity userModel = UserBaseEntity.fromJson(baseUserMap);
    SharedText.currentUser = userModel;
  }
}
