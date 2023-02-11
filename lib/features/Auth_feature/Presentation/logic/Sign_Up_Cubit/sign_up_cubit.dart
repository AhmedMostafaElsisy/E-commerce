import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/location_feature/domain/model/location_area_model.dart';
import '../../../Domain/entities/base_user_entity.dart';
import '../../../Domain/use_cases/auth_use_case.dart';
import 'sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  UserBaseEntity userModel = UserBaseEntity();

  UserBaseEntity get getUserModel => userModel;

  SignUpCubit(this._authUserCase) : super(SignUpStatesInit());

  static SignUpCubit get(context) => BlocProvider.of(context);
  final AuthUserCase _authUserCase;

  bool hidePassword = true;
  List<TextEditingController> controllerList = [];
  late bool isDataFound;

  LocationAreaModel? selectedCity;
  LocationAreaModel? selectedArea;

  setNewCitySelected(LocationAreaModel model) {
    selectedCity = model;
    selectedArea = null;
    emit(LocationSelectedState());
  }

  setSelectedArea(LocationAreaModel model) {
    selectedArea = model;
    emit(LocationSelectedState());
  }

  switchPasswordToggle() {
    hidePassword = !hidePassword;
    emit(ShowOrHidePasswordState());
  }

  singUp(
      {required String userFirstName,
      required String userLastName,
      required String email,
      required String phone,
      required String password,
      required String confirmPassword,
      required String userAddressDetails,
      required String userCity,
      required String userArea,
      required String token}) async {
    emit(UserSignUpLoadingState());

    var result = await _authUserCase.callUserSignUp(
        userFirstName: userFirstName,
        userLastName: userLastName,
        emailAddress: email,
        phoneNumber: phone,
        password: password,
        confirmPassword: confirmPassword,
        userAddressDetails: userAddressDetails,
        userArea: userArea,
        userCity: userCity,
        token: token);

    result.fold((failure) => emit(UserSignUpErrorState(error: failure)),
        (success) => emit(UserSignUpSuccessState(success)));
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

  clearAllData() {
    selectedArea = null;
    selectedCity = null;
  }
}
