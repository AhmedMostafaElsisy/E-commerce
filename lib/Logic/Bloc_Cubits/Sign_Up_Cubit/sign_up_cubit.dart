import 'package:default_repo_app/Data/Models/user_base_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Constants/Enums/exception_enums.dart';
import '../../../Data/Interfaces/auth_interface.dart';
import '../../../Data/Remote_Data/Network/Dio_Exception_Handling/custom_error.dart';
import 'sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  UserBaseModel userModel = UserBaseModel();

  UserBaseModel get getUserModel => userModel;

  SignUpCubit(this._userRepo) : super(SignUpStatesInit());

  static SignUpCubit get(context) => BlocProvider.of(context);
  final AuthRepositoryInterface _userRepo;

  singUp(
      {required String userPhoneNumber,
      required String userPassword,
      required String userEmail,
      required String userName}) async {
    emit(UserSignUpLoadingState());
    try {
      var result = await _userRepo.userSingUp(
          phoneNumber: userPhoneNumber,
          password: userPassword,
          email: userEmail,
          name: userName);

      if (_userRepo.isError) {
        emit(UserSignUpErrorState(
          error: _userRepo.errorMsg,
        ));
      } else {
        UserBaseModel baseUser = UserBaseModel.fromJson(result.data);

        userModel.id = baseUser.id;
        userModel.image = baseUser.image;
        userModel.name = baseUser.name;
        userModel.phone = baseUser.phone;
        userModel.email = baseUser.email;
        emit(UserSignUpSuccessState(userModel));
      }
    } catch (e) {
      emit(UserSignUpErrorState(
          error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
    }
  }
}
