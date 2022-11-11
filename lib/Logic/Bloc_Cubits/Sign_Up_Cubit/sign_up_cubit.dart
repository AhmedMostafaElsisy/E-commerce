import 'package:default_repo_app/Data/Models/user_base_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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
      {required String username,
      required String email,
      required String phone,
      required String password,
      required String confirmPassword,
      required String token}) async {
    emit(UserSignUpLoadingState());
    try {
      var result = await _userRepo.userSingUp(
          userName: username,
          emailAddress: email,
          phoneNumber: phone,
          password: password,
          confirmPassword: confirmPassword,
          userImage: imageXFile,
          token: token);

      if (_userRepo.isError) {
        emit(UserSignUpErrorState(
          error: _userRepo.errorMsg,
        ));
      } else {
        userModel = UserBaseModel.fromJson(result.data);

        emit(UserSignUpSuccessState(userModel));
      }
    } catch (e) {
      emit(UserSignUpErrorState(
          error: CustomError(
              type: CustomStatusCodeErrorType.unExcepted,
              errorMassage: e.toString())));
    }
  }

  set _imageFile(XFile? value) {
    imageXFile = value;
  }

  XFile? imageXFile;

  photoPicked(XFile xFile) {
    _imageFile = xFile;
    emit(UploadingUserImageLoadingState());
  }
}
