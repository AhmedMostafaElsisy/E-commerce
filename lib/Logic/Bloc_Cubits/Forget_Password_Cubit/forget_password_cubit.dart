import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Data/Interfaces/password_interface.dart';
import '../../../core/Constants/Enums/exception_enums.dart';
import '../../../core/Error_Handling/custom_error.dart';
import 'forget_password_states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit(this._repo) : super(ForgetPasswordStatesInit());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  final PasswordRepositoryInterface _repo;

  resetState() {
    emit(ForgetPasswordStatesInit());
  }

  /// Send Verification Code To Email
  sendVerificationCodeToEmail({required String email}) async {
    debugPrint("email is $email");
    emit(SendVerificationToEmailStateLoading());
    try {
      var result = await _repo.sendVerificationCodeToEmail(
        email: email,
      );
      debugPrint("here is result of user repo $result");
      if (_repo.isError) {
        emit(SendVerificationToEmailStateError(error: _repo.errorMsg!));
      } else {
        emit(SendVerificationToEmailStateSuccess());
      }
    } catch (e) {
      emit(SendVerificationToEmailStateError(
          error: CustomError(
              type: CustomStatusCodeErrorType.unExcepted,
              errorMassage: e.toString())));
    }
  }

  /// Change New Password
  changeNewPassword(
      {required String email,
        required String password,
        required String confirmPassword}) async {
    emit(ChangePasswordStateLoading());
    try {
      var result = await _repo.resetPassword(
          email: email,
          newPassword: password,
          confirmPassword: confirmPassword);

      if (_repo.isError) {
        emit(ChangePasswordStateError(
          error: _repo.errorMsg,
        ));
      } else {
        debugPrint('result: ${result.toJson().toString()}');
        emit(ChangePasswordStateSuccess());
      }
    } catch (e) {
      emit(ChangePasswordStateError(
          error: CustomError(
              type: CustomStatusCodeErrorType.unExcepted,
              errorMassage: e.toString())));
    }
  }
}
