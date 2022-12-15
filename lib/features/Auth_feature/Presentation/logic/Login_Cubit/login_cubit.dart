import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Data/model/base_user_model.dart';
import '../../../Domain/use_cases/auth_use_case.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._userUseCases) : super(LoginStatesInit());

  UserBaseModel userModel = UserBaseModel();

  UserBaseModel get getUserModel => userModel;
  final AuthUserCase _userUseCases;

  static LoginCubit get(context) => BlocProvider.of(context);

  startApp() async {
    emit(LoginIfFoundLoading());

    var result = await _userUseCases.callStartApp();

    result.fold((failure) => emit(LoginFailed()),
        (success) => emit(LoginSuccess(userModel)));
  }

  login(
      {required String email,
      required String password,
      required String token}) async {
    emit(UserLoginLoadingState());
    var result = await _userUseCases.callUserLogin(
        email: email, password: password, deviceToken: token);

    result.fold((failure) => emit(UserLoginErrorState(error: failure)),
        (success) => emit(UserLogInSuccessState()));
  }

  logOut() async {
    emit(UserLoginLoadingState());

    var result = await _userUseCases.callUserLogout();

    result.fold((failure) => emit(UserLoginErrorState(error: failure)),
        (success) => emit(UserLogoutSuccessState()));
  }
}
