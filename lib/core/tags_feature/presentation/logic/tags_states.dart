import '../../../../core/Error_Handling/custom_error.dart';

abstract class TagsLocationStates {}

class TagsInitStates extends TagsLocationStates {}

class TagsLoadingState extends TagsLocationStates {}

class TagsSuccessState extends TagsLocationStates {}
class TagsEmptyState extends TagsLocationStates {}
class FilterSearchState extends TagsLocationStates {}

class TagsErrorState extends TagsLocationStates {
  CustomError? error;

  TagsErrorState({
    this.error,
  });
}
class TagsLoadingMoreDataState extends TagsLocationStates {}

class TagsErrorMoreDataState extends TagsLocationStates {
  CustomError? error;

  TagsErrorMoreDataState({
    this.error,
  });
}
