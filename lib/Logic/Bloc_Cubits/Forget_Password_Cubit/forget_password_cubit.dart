import 'package:default_repo_app/Constants/Enums/exception_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Data/Interfaces/password_interface.dart';
import '../../../Data/Remote_Data/Network/Dio_Exception_Handling/custom_error.dart';
import 'forget_password_states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit(this._repo) : super(ForgetPasswordStatesInit());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  final PasswordRepositoryInterface _repo;

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


}
