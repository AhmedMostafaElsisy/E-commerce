import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';

abstract class DestinationStates {}

class DestinationInitialState extends DestinationStates {}

class DestinationLoadingState extends DestinationStates {}

class DestinationEmptyState extends DestinationStates {}
class DestinationSuccessState extends DestinationStates {}
class SetDestinationState extends DestinationStates {}
class DestinationNotValidState extends DestinationStates {}

class DestinationFailedState extends DestinationStates {
  CustomError error;

  DestinationFailedState(this.error);
}
