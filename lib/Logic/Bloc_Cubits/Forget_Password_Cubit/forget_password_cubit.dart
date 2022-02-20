import 'package:default_repo_app/Data/Dio_Exception_Handling/custom_error.dart';
import 'package:default_repo_app/Data/Dio_Exception_Handling/custom_exception.dart';
import 'package:default_repo_app/Logic/Repositories/forget_password_repository.dart';
import 'package:default_repo_app/Logic/Repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forget_password_states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit() : super(ForgetPasswordStatesInit());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  final UserRepository _repo = UserRepository();
  final ForgetPasswordRepository _forgetRepo = ForgetPasswordRepository();

  forgetPassword({required String phoneNumber}) async {
    emit(ForgetPasswordLoadingState());
    try {
      var result = await _repo.forgetPassword(phoneNumber: phoneNumber);

      if (_repo.isError) {
        emit(ForgetPasswordErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        debugPrint('result: ${result.toJson().toString()}');
        emit(ForgetPasswordForgetSuccessState());
      }
    } catch (e) {
      emit(ForgetPasswordErrorState(
          error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
    }
  }

  resetPassword(
      {required String phoneNumber,
      required String newPassword,
      required String confirmPassword}) async {
    emit(ForgetPasswordLoadingState());
    try {
      var result = await _forgetRepo.resetPassword(
          phoneNumber: phoneNumber,
          password: newPassword,
          newPassword: confirmPassword);

      if (_forgetRepo.isError) {
        emit(ForgetPasswordErrorState(error: _forgetRepo.errorMsg));
      } else {
        debugPrint('result: ${result.toJson().toString()}');
        emit(ForgetPasswordForgetSuccessState());
      }
    } catch (e) {
      emit(ForgetPasswordErrorState(
          error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
    }
  }
}
