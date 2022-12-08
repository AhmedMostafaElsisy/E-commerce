import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Domain/entities/base_user_entity.dart';
import '../../../Domain/repository/auth_interface.dart';
import 'sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  UserBaseEntity userModel = UserBaseEntity();

  UserBaseEntity get getUserModel => userModel;

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

    var result = await _userRepo.userSingUp(
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
}
