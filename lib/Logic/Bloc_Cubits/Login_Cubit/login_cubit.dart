import 'dart:convert';
import 'package:default_repo_app/Constants/Enums/exception_enums.dart';
import '../../../Data/Remote_Data/Network/Dio_Exception_Handling/dio_helper.dart';
import '../../../Data/Remote_Data/Network/Dio_Exception_Handling/custom_error.dart';
import 'package:default_repo_app/Data/local_source/flutter_secured_storage.dart';
import 'package:default_repo_app/Helpers/shared_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Data/Interfaces/auth_interface.dart';
import 'login_states.dart';
import 'package:default_repo_app/Data/Models/user_base_model.dart';
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._userRepo) : super(LoginStatesInit());

  UserBaseModel userModel = UserBaseModel();
  UserBaseModel get getUserModel => userModel;

  final AuthRepositoryInterface _userRepo;

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
    userModel = UserBaseModel.fromJson(baseUserMap);

    debugPrint("user from local   $userString");
    SharedText.currentUser = userModel;
    debugPrint('userModelFrom authentication ${userModel.name}');
  }

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


        String jEncode = json.encode(userModel.toJson());
        DioHelper.dio.options.headers
            .addAll({"Authorization": "Bearer ${result.data['access_token']}"});
        await DefaultSecuredStorage.setUserMap(jEncode);
        await DefaultSecuredStorage.setAccessToken(result.data['access_token']);
        await DefaultSecuredStorage.setIsLogged('true');
        SharedText.userToken =result.data['access_token'];
        SharedText.currentUser = userModel;
        emit(UserLogInSuccessState(userModel));
      }
    } catch (e) {
      emit(UserLoginErrorState(
          error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
    }
  }

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
