import 'package:default_repo_app/core/Error_Handling/custom_error.dart';
import '../../../core/Constants/Enums/exception_enums.dart';
import 'package:default_repo_app/features/Auth_feature/Domain/entities/base_user_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Data/Interfaces/profile_interface.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileCubitStates> {
  ProfileCubit(this._repo) : super(ProfileStatesInit());

  static ProfileCubit get(context) => BlocProvider.of(context);

  final ProfileRepositoryInterface _repo ;

  final ImagePicker _picker = ImagePicker();

  XFile? imageXFile;
  bool imgChange = false;
  bool isLoading = false;
  UserBaseEntity baseUser = UserBaseEntity();


  /// user Profile_Cubit data
  getUserProfileData() async {
    emit(ProfileLoadingState());
    try {
      var result = await _repo.getProfileUser();
      imgChange = false;
      if (_repo.isError) {
        emit(ProfileErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        baseUser = UserBaseEntity.fromJson(result.data);
        emit(ProfileSuccessState(baseUser));
      }
    } catch (e) {
      emit(ProfileErrorState(
          error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
    }
  }

  updateUserProfile({String? userName, String? userEmail}) async {
    emit(ProfileLoadingState());
    try {
      var result = await _repo.updateProfile(
          email: userEmail, name: userName, userImage: imageXFile);

      if (_repo.isError) {
        emit(ProfileErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        baseUser = UserBaseEntity.fromJson(result.data);
         _repo.setLocalUserData(baseUser: baseUser);

        emit(ProfileUpdateSuccessState(massage: result.message));

        emit(ProfileSuccessState(baseUser));
      }
    } catch (e) {
      emit(ProfileErrorState(
          error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
    }
  }



  set _imageFile(XFile? value) {
    imageXFile = value;
  }

  pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        imgChange = false;
        emit(ProfileSuccessState(baseUser));
      } else {
        _imageFile = pickedFile;
        imgChange = true;
        emit(ProfileSuccessState(baseUser));
      }
    } catch (e) {
      imgChange = false;
      debugPrint('Error Fetching Image: $e');
    }
  }

}
