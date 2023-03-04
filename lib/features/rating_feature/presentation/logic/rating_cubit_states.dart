import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

abstract class RatingCubitStates {}

class RatingInitialStates extends RatingCubitStates {}

class RatingLoadingStates extends RatingCubitStates {}

class RatingSuccessStates extends RatingCubitStates {}

class RatingFailedStates extends RatingCubitStates {
  CustomError error;

  RatingFailedStates(this.error);
}

class RatingListLoadingStates extends RatingCubitStates {}

class RatingListEmptyStates extends RatingCubitStates {}

class RatingListSuccessStates extends RatingCubitStates {}

class RatingListFailedStates extends RatingCubitStates {
  CustomError error;

  RatingListFailedStates(this.error);
}

class RatingListLoadingMoreDataStates extends RatingCubitStates {}

class RatingListFailedMoreDataStates extends RatingCubitStates {
  CustomError error;

  RatingListFailedMoreDataStates(this.error);
}
