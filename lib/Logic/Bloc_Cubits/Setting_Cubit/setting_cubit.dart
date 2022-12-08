import 'dart:developer';

import '../../../Data/Models/faq_model.dart';
import '../../../Data/Models/terms_model.dart';
import '../../../Domain/UesCases/setting_ues_case.dart';
import '../../../core/Constants/Enums/exception_enums.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/Error_Handling/custom_error.dart';
import 'setting_states.dart';

class SettingCubit extends Cubit<SettingCubitStates> {
  SettingCubit({required this.repo}) : super(SettingCubitStatesInit());

  static SettingCubit get(context) => BlocProvider.of(context);

  final SettingUesCase repo;

  List<FqaModel> fqaList = [];
  TermsModel termsModel = TermsModel();

  // getFqaData() async {
  //   emit(SettingCubitLoadingState());
  //   try {
  //     var result = await repo.getFqa();
  //
  //     if (repo.isError) {
  //       emit(SettingCubitErrorState(
  //         error: repo.errorMsg,
  //       ));
  //     } else {
  //       fqaList = fqaListFromJson(result.data);
  //       print("this fqa result data ${result.data}");
  //       emit(SettingCubitFqaSuccessState(fqaList: fqaList));
  //     }
  //   } catch (e) {
  //     emit(SettingCubitErrorState(
  //         error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
  //   }
  // }

  getTermsAndCondition() async {
    emit(SettingCubitLoadingState());
    try {
      var result = await repo.call();

      result.fold((failure) {
        log("here from failed case $failure");
        emit(SettingCubitErrorState(
          error: failure,
        ));
      }, (success) {
        log("here from success case $success");
        termsModel = TermsModel.fromJson(success.data);
        emit(SettingCubitTermsSuccessState(model: termsModel));
      });
    } catch (e) {
      log("here from failed case  catch ${e.toString()}");

      emit(SettingCubitErrorState(
          error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
    }
  }
}
