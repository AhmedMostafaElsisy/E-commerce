import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data/model/setting_model.dart';
import '../../Data/model/terms_model.dart';
import '../../Domain/ues_cases/setting_ues_cases.dart';
import 'setting_cubit_states.dart';


class SettingCubit extends Cubit<SettingCubitState> {
  SettingCubit(this._userUseCases) : super(SettingInitialState());

  final SettingUserCase _userUseCases;
  late SettingModel settingModel;
  late TermsModel termsModel;

  getSetting() async {
    emit(SettingLoadingState());
    var result = await _userUseCases.callAppSetting();
    result.fold((error) => emit(SettingFailedState(error)),
            (setting) {
          settingModel = setting;
          emit(SettingSuccessState());
          });
  } 
  getTermData() async {
    emit(SettingLoadingState());
    var result = await _userUseCases.callTermData();
    result.fold((error) => emit(SettingFailedState(error)),
            (termData) {
              termsModel = termData;
          emit(SettingSuccessState());
          });
  }
}
