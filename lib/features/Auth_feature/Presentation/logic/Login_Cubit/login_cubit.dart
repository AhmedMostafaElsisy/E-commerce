import 'dart:convert';
import '../../../../../Data/Remote_Data/Network/Dio_Exception_Handling/dio_helper.dart';

import 'package:default_repo_app/Data/local_source/flutter_secured_storage.dart';
import 'package:default_repo_app/core/Helpers/shared_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Domain/use_cases/login_use_case.dart';
import 'login_states.dart';
import 'package:default_repo_app/features/Auth_feature/Domain/entities/base_user_entity.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._userRepo) : super(LoginStatesInit());

  UserBaseEntity userModel = UserBaseEntity();

  UserBaseEntity get getUserModel => userModel;

  final LoginUesCase _userRepo;

  static LoginCubit get(context) => BlocProvider.of(context);

  startApp() async {
    emit(LoginIfFoundLoading());

    var result = await DefaultSecuredStorage.getIsLogged() ?? 'false';

    debugPrint("auth result is $result");

    if (result == 'true') {
      await updateUserDataFromLocalCached();

      SharedText.userToken = (await DefaultSecuredStorage.getAccessToken())!;
      debugPrint("token from local ${SharedText.userToken}");
      DioHelper.dio.options.headers
          .addAll({"Authorization": "Bearer ${SharedText.userToken}"});
      debugPrint(
          " here is option header${DioHelper.dio.options.headers.toString()}");
      emit(LoginSuccess(userModel));
    } else {
      emit(LoginFailed());
    }
  }

  updateUserDataFromLocalCached() async {
    final userString = await DefaultSecuredStorage.getUserMap();
    final baseUserMap = json.decode(userString!);
    userModel = UserBaseEntity.fromJson(baseUserMap);

    debugPrint("user from local   $userString");
    SharedText.currentUser = userModel;
    debugPrint('userModelFrom authentication ${userModel.name}');
  }

  login(
      {required String email,
      required String password,
      required String token}) async {
    emit(UserLoginLoadingState());
    var result = await _userRepo.callUserLogin(
        email: email, password: password, deviceToken:  token);

    result.fold((failure) => emit(UserLoginErrorState(error: failure)),
        (success) => emit(UserLogInSuccessState()));
  }

  logOut() async {
    emit(UserLoginLoadingState());

    var result = await _userRepo.callUserLogout();

    result.fold((failure) => emit(UserLoginErrorState(error: failure)),
        (success) => emit(UserLogoutSuccessState()));
  }
}
