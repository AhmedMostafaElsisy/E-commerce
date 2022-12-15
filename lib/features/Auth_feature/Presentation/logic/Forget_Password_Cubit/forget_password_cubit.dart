import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Domain/use_cases/forget_password_user_case.dart';
import 'forget_password_states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit(this._forgetUserCase) : super(ForgetPasswordStatesInit());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  final ForgetPasswordUesCases _forgetUserCase;

  resetState() {
    emit(ForgetPasswordStatesInit());
  }

  /// Send Verification Code To Email
  sendVerificationCodeToEmail({required String email}) async {
    emit(SendVerificationToEmailStateLoading());
    var result = await _forgetUserCase.callSndVerificationCodeToEmail(
      email: email,
    );
    result.fold(
        (failure) => emit(SendVerificationToEmailStateError(error: failure)),
        (otpCode) => emit(SendVerificationToEmailStateSuccess(otpCode)));
  }

  /// Change New Password
  changeNewPassword(
      {required String email,
      required String code,
      required String password,
      required String confirmPassword}) async {
    emit(ChangePasswordStateLoading());
    var result = await _forgetUserCase.callChangeNewPassword(
      code: code,
        email: email, password: password, confirmPassword: confirmPassword);

    result.fold((failure) => emit(ChangePasswordStateError(error: failure)),
        (success) => emit(ChangePasswordStateSuccess()));
  }
}
