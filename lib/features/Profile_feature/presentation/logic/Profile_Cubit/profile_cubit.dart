import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/location_feature/domain/model/location_area_model.dart';
import '../../../../Auth_feature/Domain/entities/base_user_entity.dart';
import '../../../Domain/user_cases/profile_ues_case.dart';
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
  List<TextEditingController> controllerList = [];
  late bool isDataFound;
  LocationAreaModel? selectedCity;
  LocationAreaModel? selectedArea;
  setNewCitySelected(LocationAreaModel model) {
    selectedCity = model;
    selectedArea = null;
    emit(ProfileAreaSelectedState());
  }

  setSelectedArea(LocationAreaModel model) {
    selectedArea = model;
    emit(ProfileAreaSelectedState());
  }

  clearAllData() {
    selectedArea = null;
    selectedCity = null;
  }

  /// user Profile_Cubit data
  getUserProfileData() async {
    emit(ProfileLoadingState());
    var result = await _uesCase.callUserProfile();
    result.fold((failure) => emit(ProfileErrorState(error: failure)),
        (success) => ProfileSuccessState());
  }

  ///update user profile
  updateUserProfile({
    required String userFirstName,
    required String userLastName,
    required String emailAddress,
    required String phoneNumber,
    required String userAddressDetails,
    required String userCity,
    required String userArea,
    required String locationId,
    XFile? image,
  }) async {
    emit(ProfileUpdateLoadingState());
    var result = await _uesCase.updateUserProfile(
        userFirstName: userFirstName,
        userLastName: userLastName,
        emailAddress: emailAddress,
        phoneNumber: phoneNumber,
        locationId: locationId,
        userAddressDetails: userAddressDetails,
        userCity: userCity,
        userArea: userArea,
        userImage: image);
    result.fold((failure) => emit(ProfileUpdateFailedState(failure)),
        (success) => emit(ProfileUpdateSuccessState()));
  }

  photoPicked(XFile xFile) {
    _imageFile = xFile;
    deleteImage = false;
    debugPrint("here is file ${xFile.toString()}");
    emit(UploadingUserImageLoadingState());
  }

  deleteImageFunc(bool value) {
    deleteImage = value;
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
}
