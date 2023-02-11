import '../../../../core/Error_Handling/custom_error.dart';

abstract class PlansStates {}

class PlansInitStates extends PlansStates {}

class PlansLoadingState extends PlansStates {}

class PlansSuccessState extends PlansStates {}
class PlansEmptyState extends PlansStates {}

class PlansErrorState extends PlansStates {
  CustomError? error;

  PlansErrorState({
    this.error,
  });
}
class PlansSelectedState extends PlansStates {}

