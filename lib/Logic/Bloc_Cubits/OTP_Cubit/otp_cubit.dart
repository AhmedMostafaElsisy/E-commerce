import 'dart:convert';
import 'package:default_repo_app/Data/Network/Dio_Exception_Handling/custom_error.dart';

import 'package:default_repo_app/Data/Network/Dio_Exception_Handling/dio_helper.dart';
import 'package:default_repo_app/Data/Enums/exception_enums.dart';
import 'package:default_repo_app/Data/Models/user_base_model.dart';
import 'package:default_repo_app/Data/Repositories/otp_repository.dart';
import 'package:default_repo_app/Helpers/flutter_secured_storage.dart';
import 'package:default_repo_app/Helpers/shared_texts.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_states.dart';

class OtpCubit extends Cubit<OtpStates> {
  UserBaseModel userModel = UserBaseModel();

  UserBaseModel get getUserModel => userModel;

  OtpCubit() : super(OtpStatesInit());

  static OtpCubit get(context) => BlocProvider.of(context);

  final OtpRepository _repo = OtpRepository();

  /// user singUp
  verifyAccountOtp(
      {required String phoneNumber, required String otpInputCode}) async {
    emit(OtpLoadingState());
    try {
      var result = await _repo.verifyAccount(
          phoneNumber: phoneNumber, code: otpInputCode);

      if (_repo.isError) {
        emit(OtpErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        UserBaseModel baseUser = UserBaseModel.fromJson(result.data["user"]);
        debugPrint("user from response json is ${baseUser.name}");
        userModel.id = baseUser.id;
        userModel.image = baseUser.image;
        userModel.name = baseUser.name;
        userModel.phone = baseUser.phone;
        userModel.email = baseUser.email;
        userModel.accessToken = result.data['access_token'];
        debugPrint("user after  is ${userModel.name}");

        DioHelper.dio.options.headers
            .addAll({"Authorization": "Bearer ${userModel.accessToken}"});
        String jEncode = json.encode(userModel.toJson());

        await DefaultSecuredStorage.setUserMap(jEncode);
        await DefaultSecuredStorage.setAccessToken(userModel.accessToken);
        await DefaultSecuredStorage.setIsLogged('true');
        SharedText.userToken = userModel.accessToken!;
        debugPrint("user model from response is ${userModel.name}");
        SharedText.currentUser = userModel;
        debugPrint("shared text model is ${SharedText.currentUser!.name}");
        emit(OtpSuccessState(userModel));
      }
    } catch (e) {
      emit(OtpErrorState(
          error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
    }
  }

  verifyForgetPasswordOtp(
      {required String phoneNumber, required String otpInputCode}) async {
    emit(OtpLoadingState());
    try {
      var result = await _repo.forgetAccount(
          phoneNumber: phoneNumber, code: otpInputCode);

      if (_repo.isError) {
        emit(OtpErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        debugPrint('result: ${result.toJson().toString()}');
        emit(OtpForgetSuccessState());
      }
    } catch (e) {
      emit(OtpErrorState(
          error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
    }
  }
}
