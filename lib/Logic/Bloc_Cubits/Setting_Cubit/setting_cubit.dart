import 'package:default_repo_app/Data/Network/Dio_Exception_Handling/custom_error.dart';
import 'package:default_repo_app/Data/Enums/exception_enums.dart';
import 'package:default_repo_app/Data/Models/faq_model.dart';
import 'package:default_repo_app/Data/Models/terms_model.dart';
import 'package:default_repo_app/Data/Repositories/setting_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'setting_states.dart';

class SettingCubit extends Cubit<SettingCubitStates> {
  SettingCubit() : super(SettingCubitStatesInit());

  static SettingCubit get(context) => BlocProvider.of(context);

  final SettingRepository _repo = SettingRepository();

  List<FqaModel> fqaList = [];
  TermsModel termsModel = TermsModel();

  getFqaData() async {
    emit(SettingCubitLoadingState());
    try {
      var result = await _repo.getFqa();

      if (_repo.isError) {
        emit(SettingCubitErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        fqaList = fqaListFromJson(result.data);
        emit(SettingCubitFqaSuccessState(fqaList: fqaList));
      }
    } catch (e) {
      emit(SettingCubitErrorState(
          error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
    }
  }

  getTermsAndCondition() async {
    emit(SettingCubitLoadingState());
    try {
      var result = await _repo.getTermsAndConditions();

      if (_repo.isError) {
        emit(SettingCubitErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        termsModel = TermsModel.fromJson(result.data);
        emit(SettingCubitTermsSuccessState(model: termsModel));
      }
    } catch (e) {
      emit(SettingCubitErrorState(
          error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
    }
  }
}
