import 'dart:developer';

import '../../../core/Constants/Enums/exception_enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Data/Interfaces/otp_interface.dart';
import '../../../core/Error_Handling/custom_error.dart';
import 'otp_states.dart';

class OtpCubit extends Cubit<OtpStates> {
  OtpCubit(this._repo) : super(OtpStatesInit());

  static OtpCubit get(context) => BlocProvider.of(context);

  final OtpRepositoryInterface _repo;

  resetState() {
    emit(OtpStatesInit());
  }

  /// Verify Forget Password
  verifyAccount({required String emailAddress, required String otp}) async {
    emit(OtpLoadingState());
    try {
      await _repo.verifyAccount(email: emailAddress, code: otp);

      if (_repo.isError) {
        emit(OtpErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        emit(OtpSuccessState());
      }
    } catch (e) {
      emit(OtpErrorState(
          error: CustomError(
              type: CustomStatusCodeErrorType.unExcepted,
              errorMassage: e.toString())));
    }
  }

  ///re send
  resendOTP({required String email}) async {
    emit(ResendOtpLoadingState());
    try {
      var result = await _repo.resendOTP(
        email: email,
      );

      if (_repo.isError) {
        emit(OtpErrorState(
            error: CustomError(
                errorMassage: _repo.errorMsg!.errorMassage.toString(),
                type: CustomStatusCodeErrorType.unExcepted)));
      } else {
        log("this the result data ${result.data}");
        emit(ResendOtpSuccessState());
      }
    } catch (e) {
      emit(OtpErrorState(
          error: CustomError(
              errorMassage: e.toString(),
              type: CustomStatusCodeErrorType.unExcepted)));
    }
  }
}
