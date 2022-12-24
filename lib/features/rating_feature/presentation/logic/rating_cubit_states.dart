import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

abstract class RatingCubitStates {}

class RatingInitialStates extends RatingCubitStates {}

class RatingLoadingStates extends RatingCubitStates {}

class RatingSuccessStates extends RatingCubitStates {}

class RatingFailedStates extends RatingCubitStates {
  CustomError error;

  RatingFailedStates(this.error);
}
