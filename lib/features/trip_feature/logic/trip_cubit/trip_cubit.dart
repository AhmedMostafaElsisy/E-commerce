import 'dart:developer';

import 'package:captien_omda_customer/features/Home_feature/Domain/enitiy/location_model.dart';
import 'package:captien_omda_customer/features/trip_feature/logic/trip_cubit/trip_cubit_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Home_feature/Domain/enitiy/request_model.dart';
import '../../Domain/ues_cases/trip_ues_case.dart';

class TripCubit extends Cubit<TripCubitState> {
  TripCubit(this._requestUesCase) : super(TripInitialState());
  final TripUesCases _requestUesCase;

  static TripCubit get(context) => BlocProvider.of(context);
  late RequestModel requestModel;

  startTrip({
    required LocationModel fromModel,
    required LocationModel toModel,
  }) async {
    emit(TripLoadingState());
    var result = await _requestUesCase.callStartTrip(
        locationFromId: fromModel.id!, locationToId: toModel.id!);

    result.fold(
      (failure) => emit(TripFailedState(failure)),
      (request) {
        requestModel = request;
        log("this request data $requestModel");
        emit(TripSuccessState());
      },
    );
  }

  changeRequestSates({required int requestId, required String states}) async {
    emit(ChangeStatesTripLoadingState());
    var result = await _requestUesCase.callChangeRequestStates(
        requestID: requestId, states: states);

    result.fold(
      (failure) => emit(ChangeStatesTripFailedState(failure)),
      (request) {
        emit(ChangeStatesTripSuccessState());
      },
    );
  }

  getCurrentRequest() async {
    emit(CurrentTripLoadingState());
    var result = await _requestUesCase.callCurrentRequest();

    result.fold(
      (failure) => emit(CurrentTripFailedState(failure)),
      (request) {
        requestModel = request;
        emit(CurrentTripSuccessState());
      },
    );
  }
}
