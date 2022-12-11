import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/repository/otp_interface.dart';
import '../../../../core/Constants/Enums/exception_enums.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../Domain/use_case/otp_ues_cases.dart';
import 'otp_states.dart';

class OtpCubit extends Cubit<OtpStates> {
  OtpCubit(this._otpUesCases) : super(OtpStatesInit());

  static OtpCubit get(context) => BlocProvider.of(context);

  final OtpUesCases _otpUesCases;

  resetState() {
    emit(OtpStatesInit());
  }

  /// Verify Forget Password
  verifyAccount({required String emailAddress, required String otp}) async {
    emit(OtpLoadingState());
    var result =
        await _otpUesCases.callVerifyAccount(email: emailAddress, code: otp);
    result.fold((faulier) {
      emit(OtpErrorState(
        error: faulier,
      ));
    }, (r) => emit(OtpSuccessState()));
  }

  ///re send
  resendOTP({required String email}) async {
    emit(ResendOtpLoadingState());
    var result = await _otpUesCases.callResendCode(email: email);
    result.fold((faulier) {
      emit(OtpErrorState(
        error: faulier,
      ));
    }, (r) => emit(ResendOtpSuccessState()));
  }
}
