import 'dart:convert';
import 'package:default_repo_app/Data/Dio_Exception_Handling/custom_error.dart';
import 'package:default_repo_app/Data/Enums/exception_enums.dart';
import 'package:default_repo_app/Data/Dio_Exception_Handling/dio_helper.dart';
import 'package:default_repo_app/Data/Models/user_base_model.dart';
import 'package:default_repo_app/Data/Repositories/user_repository.dart';
import 'package:default_repo_app/Helpers/flutter_secured_storage.dart';
import 'package:default_repo_app/Helpers/shared_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  bool isLoading = false;
  String message = '';

  UserBaseModel userModel = UserBaseModel();
  UserBaseModel get getUserModel => userModel;

  final UserRepository _userRepo;

  LoginCubit(this._userRepo) : super(LoginStatesInit());

  static LoginCubit get(context) => BlocProvider.of(context);

  startApp() async {
    emit(LoginIfFoundLoading());
    isLoading = true;

    var result = await DefaultSecuredStorage.getIsLogged() ?? 'false';

    debugPrint("auth result is $result");

    if (result == 'true') {
      isLoading = false;
      message = 'Success';
      await updateUserDataFromLocalCached();
      // print("token from local ${userModel.accessToken}");
      SharedText.userToken = (await DefaultSecuredStorage.getAccessToken())!;
      debugPrint("token from local ${SharedText.userToken}");
      DioHelper.dio.options.headers
          .addAll({"Authorization": "Bearer ${SharedText.userToken}"});
      debugPrint(
          " here is option header${DioHelper.dio.options.headers.toString()}");
      emit(LoginSuccess(userModel));
    } else {
      isLoading = false;
      message = 'Failed';

      emit(LoginFailed());
    }
  }

  updateUserDataFromLocalCached() async {
    final userString = await DefaultSecuredStorage.getUserMap();
    final baseUserMap = json.decode(userString!);
    userModel = UserBaseModel.fromJson(baseUserMap);

    debugPrint("user from local   $userString");
    SharedText.currentUser = userModel;
    userModel.accessToken = baseUserMap["access_token"];
    debugPrint('userModelFrom authentication ${userModel.name}');
  }

  /// doctor to login
  login({required String phoneNumber, required String userPassword}) async {
    emit(UserLoginLoadingState());
    try {
      var result = await _userRepo.loginUser(
        phoneNumber: phoneNumber,
        password: userPassword,
      );

      debugPrint("here is result of user repo $result");
      if (_userRepo.isError) {
        if (_userRepo.errorMsg!.type == CustomStatusCodeErrorType.unVerified) {
          emit(LoginUnVerifiedState(userPhone: phoneNumber));
        } else {
          emit(UserLoginErrorState(
              error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
        }
      } else {
        debugPrint('baseUser: ${result.data["user"]}');
        debugPrint('baseUser: ${result.data["access_token"]}');

        userModel = UserBaseModel.fromJson(result.data["user"]);

        userModel.accessToken = result.data['access_token'];

        String jEncode = json.encode(userModel.toJson());
        DioHelper.dio.options.headers
            .addAll({"Authorization": "Bearer ${userModel.accessToken}"});
        await DefaultSecuredStorage.setUserMap(jEncode);
        await DefaultSecuredStorage.setAccessToken(userModel.accessToken);
        await DefaultSecuredStorage.setIsLogged('true');
        SharedText.userToken = userModel.accessToken!;
        SharedText.currentUser = userModel;
        debugPrint("here i am ");
        emit(UserLogInSuccessState(userModel));
      }
    } catch (e) {
      emit(UserLoginErrorState(
          error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
    }
  }

  ///doctor logout
  logOut() async {
    try {
      emit(UserLoginLoadingState());
      await DefaultSecuredStorage.setUserMap(null);
      await DefaultSecuredStorage.setAccessToken(null);
      await DefaultSecuredStorage.setIsLogged('false');
      SharedText.userToken = "";
      DioHelper.dio.options.headers.remove("Authorization");
      debugPrint(
          " here is option header${DioHelper.dio.options.headers.toString()}");
      emit(UserLogoutSuccessState());
    } catch (e) {
      emit(UserLoginErrorState(
          error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
    }
  }
}
