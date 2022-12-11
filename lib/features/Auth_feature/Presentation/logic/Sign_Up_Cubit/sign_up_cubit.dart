import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Domain/entities/base_user_entity.dart';
import '../../../Domain/use_cases/login_use_case.dart';
import 'sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  UserBaseEntity userModel = UserBaseEntity();

  UserBaseEntity get getUserModel => userModel;

  SignUpCubit(this._authUserCase) : super(SignUpStatesInit());

  static SignUpCubit get(context) => BlocProvider.of(context);
  final AuthUserCase _authUserCase;

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  List<TextEditingController> controllerList = [];
  late bool isDataFound;

  switchPasswordToggle({bool? isMainPassword = true}) {
    if (isMainPassword!) {
      hidePassword = !hidePassword;
    } else {
      hideConfirmPassword = !hideConfirmPassword;
    }
    emit(ShowOrHidePasswordState());
  }

  singUp(
      {required String username,
      required String email,
      required String phone,
      required String password,
      required String confirmPassword,
      required String token}) async {
    emit(UserSignUpLoadingState());

    var result = await _authUserCase.callUserSignUp(
        userName: username,
        emailAddress: email,
        phoneNumber: phone,
        password: password,
        confirmPassword: confirmPassword,
        userImage: imageXFile,
        token: token);

    result.fold((failure) => emit(UserSignUpErrorState(error: failure)),
        (success) => emit(UserSignUpSuccessState(success)));
  }

  set _imageFile(XFile? value) {
    imageXFile = value;
  }

  XFile? imageXFile;

  photoPicked(XFile xFile) {
    _imageFile = xFile;
    emit(UploadingUserImageLoadingState());
  }

  void isDataFount(List<TextEditingController> list) {
    isDataFound = true;
    emit(CheckInputValidationState());

    for (var element in list) {
      if (element.text.isEmpty) {
        isDataFound = false;
        return;
      }
    }
    emit(CheckInputValidationState());
  }

  clearSelectedImage() {
    imageXFile = null;
    emit(UploadingUserImageLoadingState());
  }
}
