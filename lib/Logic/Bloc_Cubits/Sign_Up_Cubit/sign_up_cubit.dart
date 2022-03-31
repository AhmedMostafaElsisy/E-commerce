import 'package:default_repo_app/Data/Models/user_base_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  UserBaseModel userModel = UserBaseModel();

  UserBaseModel get getUserModel => userModel;

  SignUpCubit() : super(SignUpStatesInit());

  static SignUpCubit get(context) => BlocProvider.of(context);
  // final UserRepository _userRepo = UserRepository();

  /// user singUp
  // singUp() async {
  //   emit(UserSignUpLoadingState());
  //   try {
  //     var result = await _userRepo.userSingUp(
  //         phoneNumber: phoneController.text,
  //         password: passwordController.text,
  //         email: emailController.text,
  //         name: nameController.text);
  //
  //     if (_userRepo.isError) {
  //       emit(UserSignUpErrorState(
  //         error: _userRepo.errorMsg,
  //       ));
  //     } else {
  //       UserBaseModel baseUser = UserBaseModel.fromJson(result.data);
  //
  //       userModel.id = baseUser.id;
  //       userModel.image = baseUser.image;
  //       userModel.name = baseUser.name;
  //       userModel.phone = baseUser.phone;
  //       userModel.email = baseUser.email;
  //       emit(UserSignUpSuccessState(userModel));
  //     }
  //   } catch (e) {
  //     emit(UserSignUpErrorState(
  //         error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
  //   }
  // }
}
