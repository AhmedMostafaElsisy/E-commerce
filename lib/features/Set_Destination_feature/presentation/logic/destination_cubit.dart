import 'package:captien_omda_customer/features/Home_feature/Domain/enitiy/location_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:rxdart/rxdart.dart';

import '../../Domain/location_ues_cases/location_ues_cases.dart';
import 'destination_event.dart';
import 'destination_states.dart';

class DestinationCubit extends Bloc<SearchEvents, DestinationStates> {
  final LocationUesCases _locationUesCase;

  static DestinationCubit get(context) => BlocProvider.of(context);
  List<LocationModel> locationList = [];
  LocationModel? destinationFrom;
  LocationModel? destinationTo;

  DestinationCubit(this._locationUesCase) : super(DestinationInitialState()) {
    ///Search event
    on<SearchClickEvent>(
      (event, emit) async {
        emit(DestinationLoadingState());

        var result =
            await _locationUesCase.callLocationList(searchKey: event.text);

        result.fold(
          (failure) => emit(DestinationFailedState(failure)),
          (locationList) {
            if (locationList.isEmpty) {
              emit(DestinationEmptyState());
            } else {
              this.locationList = locationList;
              emit(DestinationSuccessState());
            }
          },
        );
      },

      ///waite 500 mill after user last input then call the func
      transformer: (eventsStream, mapper) => eventsStream
          .debounceTime(const Duration(milliseconds: 500))
          .switchMap(mapper),
    );

    ///set destination event
    on<SetDestinationEvent>((event, emit) {
      if (event.isFromLocation) {
        if (destinationTo == null || (destinationTo!.id != event.model.id)) {
          destinationFrom = event.model;
          emit(SetDestinationState());
        } else {
          emit(DestinationNotValidState());
        }
      } else {
        if (destinationFrom == null ||
            (destinationFrom!.id != event.model.id)) {
          destinationTo = event.model;
          emit(SetDestinationState());
        } else {
          emit(DestinationNotValidState());
        }
      }
    });
  }

  ///clear all data
  clearData() {
    locationList.clear();
    destinationFrom = null;
    destinationTo = null;
  }
}
