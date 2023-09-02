import '../../../../core/Error_Handling/custom_error.dart';

abstract class PickLocationStates {}

class PickLocationInitStates extends PickLocationStates {}

class PickLocationLoadingState extends PickLocationStates {}

class PickLocationSuccessState extends PickLocationStates {}
class FilterSearchState extends PickLocationStates {}

class LocationServiceDisabledState extends PickLocationStates {}

class LocationPermissionDisabledState extends PickLocationStates {}

class LocationPermissionDisabledForEverState extends PickLocationStates {}

class PickLocationErrorState extends PickLocationStates {
  CustomError? error;

  PickLocationErrorState({
    this.error,
  });
}

class CityLocationLoadingState extends PickLocationStates {}

class CityLocationEmptyState extends PickLocationStates {}
class CityLocationSuccessState extends PickLocationStates {}

class CityLocationFailedState extends PickLocationStates {
  CustomError error;

  CityLocationFailedState(this.error);
}

class CityLocationLoadingMoreDataState extends PickLocationStates {}

class CityLocationFailedMoreDataState extends PickLocationStates {
  CustomError error;

  CityLocationFailedMoreDataState(this.error);
}
class AreaLocationLoadingState extends PickLocationStates {}

class AreaLocationEmptyState extends PickLocationStates {}
class AreaLocationSuccessState extends PickLocationStates {}

class AreaLocationFailedState extends PickLocationStates {
  CustomError error;

  AreaLocationFailedState(this.error);
}

class AreaLocationLoadingMoreDataState extends PickLocationStates {}

class AreaLocationFailedMoreDataState extends PickLocationStates {
  CustomError error;

  AreaLocationFailedMoreDataState(this.error);
}

