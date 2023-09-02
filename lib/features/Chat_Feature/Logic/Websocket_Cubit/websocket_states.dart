import '../../Data/chat_models/socket/socket_model.dart';

abstract class WebsocketStates {}

class WebsocketInitStates extends WebsocketStates {}

class WebsocketClosedStates extends WebsocketStates {}

class WebsocketLoadingStates extends WebsocketStates {}

class WebsocketEstablishSuccessStates extends WebsocketStates {
  final SocketModel socketModel;

  WebsocketEstablishSuccessStates({required this.socketModel});
}

class WebSocketUserTypingState extends WebsocketStates {
  final SocketModel socketModel;

  WebSocketUserTypingState({required this.socketModel});
}

class WebSocketUserHaveAnMessageState extends WebsocketStates {
  final SocketModel socketModel;

  WebSocketUserHaveAnMessageState({required this.socketModel});
}

class WebsocketRequestCanceledStates extends WebsocketStates {
  final String error;

  WebsocketRequestCanceledStates(this.error);
}

class WebsocketEndedSuccessStatus extends WebsocketStates {
  final String finalPrice;

  WebsocketEndedSuccessStatus(this.finalPrice);
}

class WebsocketFailedStates extends WebsocketStates {
  final String error;

  WebsocketFailedStates(this.error);
}
