import 'package:captien_omda_customer/core/setting_feature/Data/model/setting_model.dart';
import 'package:captien_omda_customer/core/setting_feature/Logic/setting_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Domain/ues_cases/setting_ues_cases.dart';

class SettingCubit extends Cubit<SettingCubitState> {
  SettingCubit(this._userUseCases) : super(SettingInitialState());

  final SettingUserCase _userUseCases;
  late SettingModel settingModel;

  getSetting() async {
    emit(SettingLoadingState());
    var result = await _userUseCases.callAppSetting();
    result.fold((error) => emit(SettingFailedState(error)),
            (setting) {
          settingModel = setting;
          emit(SettingSuccessState());
          });
  }
}
