import '../../../../Auth_feature/Domain/entities/base_user_entity.dart';
import '../../../Domain/user_cases/profile_ues_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileCubitStates> {
  ProfileCubit(this._uesCase) : super(ProfileStatesInit());

  static ProfileCubit get(context) => BlocProvider.of(context);

  final ProfileUesCases _uesCase;

  set _imageFile(XFile? value) {
    imageXFile = value;
  }

  XFile? imageXFile;
  bool imgChange = false;
  bool deleteImage = false;
  UserBaseEntity baseUser = UserBaseEntity();

  /// user Profile_Cubit data
  getUserProfileData() async {
    emit(ProfileLoadingState());
    var result = await _uesCase.callUserProfile();
    result.fold((failure) => emit(ProfileErrorState(error: failure)),
        (success) => ProfileSuccessState());
  }

  ///update user profile
  updateUserProfile({
    required String name,
    required String? phone,
    XFile? image,
  }) async {
    emit(ProfileUpdateLoadingState());
    var result = await _uesCase.updateUserProfile(
        name: name, phone: phone, userImage: image);
    result.fold((failure) => emit(ProfileUpdateFailedState(failure)),
        (success) => emit(ProfileUpdateSuccessState()));
  }

  photoPicked(XFile xFile) {
    _imageFile = xFile;
    deleteImage = false;
    emit(UploadingUserImageLoadingState());
  }

  deleteImageFunc(bool value) {
    deleteImage = value;
    emit(UploadingUserImageLoadingState());
  }
}
