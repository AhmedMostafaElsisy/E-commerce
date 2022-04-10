import 'dart:convert';
import 'package:default_repo_app/Data/Remote_Data/Network/Dio_Exception_Handling/custom_error.dart';
import 'package:default_repo_app/Data/Remote_Data/Network/Dio_Exception_Handling/dio_helper.dart';
import 'package:default_repo_app/Constants/Enums/exception_enums.dart';
import 'package:default_repo_app/Data/Models/user_base_model.dart';
import 'package:default_repo_app/Data/Remote_Data/Repositories/otp_repository.dart';
import 'package:default_repo_app/Data/local_source/flutter_secured_storage.dart';
import 'package:default_repo_app/Helpers/shared_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Data/Interfaces/otp_interface.dart';
import 'otp_states.dart';

class OtpCubit extends Cubit<OtpStates> {
  UserBaseModel userModel = UserBaseModel();

  UserBaseModel get getUserModel => userModel;

  OtpCubit(this._repo) : super(OtpStatesInit());

  static OtpCubit get(context) => BlocProvider.of(context);

  final OtpRepositoryInterface _repo ;

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
        userModel= UserBaseModel.fromJson(result.data["user"]);
        debugPrint("user from response json is ${userModel.name}");

        debugPrint("user after  is ${userModel.name}");

        DioHelper.dio.options.headers
            .addAll({"Authorization": "Bearer ${result.data['access_token']}"});
        String jEncode = json.encode(userModel.toJson());

        await DefaultSecuredStorage.setUserMap(jEncode);
        await DefaultSecuredStorage.setAccessToken(result.data['access_token']);
        await DefaultSecuredStorage.setIsLogged('true');
        SharedText.userToken =result.data['access_token'];
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
