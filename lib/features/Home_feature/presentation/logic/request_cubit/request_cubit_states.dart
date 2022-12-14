import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

import '../../../Domain/enitiy/request_model.dart';

abstract class RequestCubitState {}

class RequestInitialState extends RequestCubitState {}

class RequestHomeLoadingState extends RequestCubitState {}

class RequestHomeSuccessState extends RequestCubitState {
  List<RequestModel> requestList;

  RequestHomeSuccessState(this.requestList);
}

class RequestHomeEmptyState extends RequestCubitState {}

class RequestHomeFailedState extends RequestCubitState {
  CustomError error;

  RequestHomeFailedState(this.error);
}
