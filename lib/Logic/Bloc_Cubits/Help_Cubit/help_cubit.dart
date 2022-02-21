import 'package:default_repo_app/Data/Dio_Exception_Handling/custom_error.dart';

import 'package:default_repo_app/Data/Dio_Exception_Handling/exception_enums.dart';import 'package:default_repo_app/Logic/Repositories/help_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'help_cubit_states.dart';

class HelpCubit extends Cubit<HelpStates> {
  HelpCubit() : super(HelpStatesInit());

  static HelpCubit get(context) => BlocProvider.of(context);

  final HelpRepository _repo = HelpRepository();

  sendHelp(
      {required String phoneNumber,
      required String userName,
      required String userSubject,
      required String userMassage}) async {
    emit(HelpLoadingState());
    try {
      var result = await _repo.helpUser(
          phoneNumber: phoneNumber,
          massage: userMassage,
          name: userName,
          subject: userSubject);

      if (_repo.isError) {
        emit(HelpErrorState(error: _repo.errorMsg));
      } else {
        emit(HelpSuccessState(massage: result.message));
      }
    } catch (e) {
      emit(HelpErrorState(
          error: CustomError(type: CustomStatusCodeErrorType.unExcepted)));
    }
  }
}
