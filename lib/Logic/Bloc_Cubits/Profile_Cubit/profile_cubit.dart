import '../../../core/Constants/Enums/exception_enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Data/Interfaces/profile_interface.dart';
import '../../../core/Error_Handling/custom_error.dart';
import '../../../features/Auth_feature/Domain/entities/base_user_entity.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileCubitStates> {
  ProfileCubit(this._repo) : super(ProfileStatesInit());

  static ProfileCubit get(context) => BlocProvider.of(context);

  final ProfileRepositoryInterface _repo;


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

  photoPicked(XFile xFile) {
    _imageFile = xFile;
    deleteImage=false;
    emit(UploadingUserImageLoadingState());
  }

  deleteImageFunc(bool value) {
    deleteImage = value;
    emit(UploadingUserImageLoadingState());

  }
}
