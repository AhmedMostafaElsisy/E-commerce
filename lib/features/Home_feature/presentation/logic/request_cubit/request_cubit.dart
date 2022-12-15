import 'package:captien_omda_customer/features/Home_feature/Domain/enitiy/request_model.dart';

import '../../../Domain/use_cases/request_use_case.dart';
import 'request_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestCubit extends Cubit<RequestCubitState> {
  RequestCubit(this._requestUesCase) : super(RequestInitialState());
  final RequestUesCases _requestUesCase;

  static RequestCubit get(context) => BlocProvider.of(context);
List<RequestModel> requestList=[];
  ///get home screen requests
  getHomeRequest() async {
    emit(RequestHomeLoadingState());
    var result = await _requestUesCase.callHomeRequest();

    result.fold(
      (failure) => emit(RequestHomeFailedState(failure)),
      (requestList) {
        if (requestList.isEmpty) {
          emit(RequestHomeEmptyState());
        } else {
          this.requestList=requestList;
          emit(RequestHomeSuccessState(requestList));
        }
      },
    );
  }
}
