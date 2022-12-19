import 'package:captien_omda_customer/features/Home_feature/Domain/enitiy/request_model.dart';
import 'package:flutter/cupertino.dart';
import '../../../Domain/use_cases/request_use_case.dart';
import 'request_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestCubit extends Cubit<RequestCubitState> {
  RequestCubit(this._requestUesCase) : super(RequestInitialState());
  final RequestUesCases _requestUesCase;

  static RequestCubit get(context) => BlocProvider.of(context);
  List<RequestModel> requestList = [];
  List<RequestModel> requestHistoryList = [];

  late RequestModel requestModel;

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  bool hasMoreData = false;

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
          this.requestList = requestList;
          emit(RequestHomeSuccessState(requestList));
        }
      },
    );
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! RequestMoreDataHistoryLoadingState && hasMoreData) {
        whenScrollHistoryPagination();
      }
    }
  }

  ///get request history pagination
  whenScrollHistoryPagination() async {
    emit(RequestMoreDataHistoryLoadingState());
    page = page + 1;
    var result = await _requestUesCase.callHistoryRequest(page: page);

    result.fold(
      (failure) => emit(RequestMoreHistoryFailedState(failure)),
      (requestList) {
        hasMoreData = requestList.length == 10;
        requestHistoryList.addAll(requestList);
        emit(RequestHistorySuccessState());
      },
    );
  }

  ///get request history list
  getRequestHistory() async {
    emit(RequestHistoryLoadingState());
    page = 1;
    var result = await _requestUesCase.callHistoryRequest(page: page);

    result.fold(
      (failure) => emit(RequestHistoryFailedState(failure)),
      (requestList) {
        hasMoreData = requestList.length == 10;
        if (requestList.isEmpty) {
          emit(RequestHistoryEmptyState());
        } else {
          requestHistoryList = requestList;
          emit(RequestHistorySuccessState());
        }
      },
    );
  }

  ///get request details
  getRequestDetails({required int requestId}) async {
    emit(RequestDetailsLoadingState());

    var result = await _requestUesCase.callRequestDetails(
      requestId: requestId,
    );

    result.fold(
      (failure) => emit(RequestDetailsFailedState(failure)),
      (request) {
        requestModel = request;
        emit(RequestDetailsSuccessState());
      },
    );
  }
}
