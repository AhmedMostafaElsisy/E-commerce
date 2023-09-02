import '../../../../core/Error_Handling/custom_error.dart';

abstract class ChatDetailsStates {}

class ChatInitialStates extends ChatDetailsStates {}

class ChatAttachmentToggleStates extends ChatDetailsStates {}

class ChatMassageLoadingStates extends ChatDetailsStates {}

class ChatMassageSuccessStates extends ChatDetailsStates {}

class ChatMassageFailedStates extends ChatDetailsStates {
  CustomError error;

  ChatMassageFailedStates(this.error);
}

class ChatMassageBackGroundLoadingStates extends ChatDetailsStates {}

class ChatMassageBackGroundSuccessStates extends ChatDetailsStates {}

class ChatMassageBackGroundFailedStates extends ChatDetailsStates {
  CustomError error;

  ChatMassageBackGroundFailedStates(this.error);
}

class ChatMassageFileSuccessStates extends ChatDetailsStates {}

class UserAddressDetectedState extends ChatDetailsStates {}

class MapCubitPermissionDeniedState extends ChatDetailsStates {}

class MapCubitPermissionDeniedNeverState extends ChatDetailsStates {
  String massage;

  MapCubitPermissionDeniedNeverState({required this.massage});
}

class SendChatMassageSuccessStates extends ChatDetailsStates {}

class SendChatMassageLoadingStates extends ChatDetailsStates {}

class SendChatMassageFailedStates extends ChatDetailsStates {
  CustomError error;

  SendChatMassageFailedStates(this.error);
}
