import '../../../../core/Error_Handling/custom_error.dart';

abstract class TripCubitState {}

class TripInitialState extends TripCubitState {}

class TripLoadingState extends TripCubitState {}

class TripSuccessState extends TripCubitState {}

class TripFailedState extends TripCubitState {
  CustomError error;

  TripFailedState(this.error);
}
