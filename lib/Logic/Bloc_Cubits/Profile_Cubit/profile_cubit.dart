import 'dart:convert';
import 'package:default_repo_app/Data/Dio_Exception_Handling/custom_error.dart';
import 'package:default_repo_app/Data/Enums/exception_enums.dart';
import 'package:default_repo_app/Data/Models/user_base_model.dart';
import 'package:default_repo_app/Data/Repositories/user_repository.dart';
import 'package:default_repo_app/Helpers/flutter_secured_storage.dart';
import 'package:default_repo_app/Helpers/shared_texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileCubitStates> {
  ProfileCubit() : super(ProfileStatesInit());

  static ProfileCubit get(context) => BlocProvider.of(context);

  final UserRepository _repo = UserRepository();

  final ImagePicker _picker = ImagePicker();

  XFile? imageXFile;
  bool imgChange = false;
  bool isLoading = false;
  UserBaseModel baseUser = UserBaseModel();

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
        baseUser = UserBaseModel.fromJson(result.data);
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
        baseUser = UserBaseModel.fromJson(result.data);
        String jEncode = json.encode(baseUser.toJson());

        await DefaultSecuredStorage.setUserMap(jEncode);

        await DefaultSecuredStorage.setIsLogged('true');

        SharedText.currentUser = baseUser;

        emit(ProfileUpdateSuccessState(massage: result.message));

        emit(ProfileSuccessState(baseUser));
      }
    } catch (e) {
      emit(ProfileErrorState(
          error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
    }
  }

  changePassword(
      {required String currentPassword,
      required String newPassword,
      required String confirmPassword}) async {
    try {
      isLoading = false;
      if (newPassword == confirmPassword) {
        isLoading = true;
        var result = await _repo.changePassword(
            currentPassword: currentPassword,
            newPassword: newPassword,
            confirmPassword: confirmPassword);

        if (_repo.isError) {
          isLoading = false;
          emit(ProfileErrorState(
            error: _repo.errorMsg,
          ));
          emit(ProfileSuccessState(baseUser));
        } else {
          isLoading = false;
          emit(ProfileUpdateSuccessState(massage: result.message));
          emit(ProfileSuccessState(baseUser));
        }
      } else {
        isLoading = false;
        emit(ChangePasswordNotMatchState());
        emit(ProfileSuccessState(baseUser));
      }
    } catch (e) {
      emit(ProfileErrorState(
          error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
    }
  }
}
