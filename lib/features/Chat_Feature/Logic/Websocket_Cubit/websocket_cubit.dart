import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../core/Constants/Enums/chat/socket_connection_enum.dart';
import '../../../../core/Constants/base_urls.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/model/base_model.dart';
import '../../Data/chat_models/socket/socket_model.dart';
import '../../Domain/interfaces/chat_realtime_interface.dart';
import 'websocket_states.dart';

class WebsocketCubit extends Cubit<WebsocketStates> {
  ChatRealTimeRepositoryInterface chatRealTimeRepositoryInterface;

  WebsocketCubit({required this.chatRealTimeRepositoryInterface})
      : super(WebsocketInitStates());

  late WebSocketChannel _webSocketChannel;

  late SocketModel responseOfSocket;
  late BaseModel modelOfAuthInSocket;

  void initSocket() {
    emit(WebsocketLoadingStates());
    _webSocketChannel = WebSocketChannel.connect(
      Uri.parse(BaseUrls.webSocketUrl),
    );

    listenToReceivedData();
  }

  void listenToReceivedData() {
    SharedText.currentTimerOfSocket?.cancel();
    SharedText.currentTimerOfSocket = null;
    try {
      _webSocketChannel.stream.listen(
        (data) async {
          debugPrint("here is data from socket after listen$data");

          responseOfSocket = SocketModel.fromJson(jsonDecode(data));
          switch (responseOfSocket.socketEventEnum) {
            case SocketEventEnum.init:
              // TODO: Handle this case.
              break;
            case SocketEventEnum.connection_established:
              _pingSocketJson();

              emit(WebsocketEstablishSuccessStates(
                  socketModel: responseOfSocket));
              await chatRealTimeRepositoryInterface
                  .authYouOnChat(
                      socketId: responseOfSocket.eventData?["socket_id"])
                  .then(
                (responseOfChatAuth) {
                  modelOfAuthInSocket = responseOfChatAuth;
                  subScribeToChannelInSocket(
                      "private-chatify.${responseOfChatAuth.data["user_id"]}");
                },
              );
              break;
            case SocketEventEnum.client_typing:
              if (SharedText.currentUserOfChat != null &&
                  SharedText.currentUserOfChat!.id.toString() ==
                      responseOfSocket.eventData?["from_id"]) {
                emit(WebSocketUserTypingState(socketModel: responseOfSocket));
              }
              break;
            case SocketEventEnum.client_contactItem:
              if (SharedText.currentUserOfChat != null &&
                  SharedText.currentUserOfChat!.id.toString() ==
                      responseOfSocket.eventData?["update_to"].toString()) {
                debugPrint(
                    "here is user data ${SharedText.currentUserOfChat!.id.toString()}");
                debugPrint(
                    "here is user data ${responseOfSocket.eventData?["update_to"]}");
                emit(WebSocketUserHaveAnMessageState(
                    socketModel: responseOfSocket));
              }
              break;
          }
        },
        onError: (error) {
          debugPrint(
              "here is data from socket after error ${error.toString()}");
          emit(WebsocketFailedStates(error.toString()));
        },
        onDone: () {
          debugPrint("here is data from socket after done  ");

          if (!(state is WebsocketClosedStates ||
              state is WebsocketRequestCanceledStates)) {
            _webSocketChannel = WebSocketChannel.connect(
              Uri.parse(BaseUrls.webSocketUrl),
            );
            listenToReceivedData();
          }
        },
      );
    } catch (e) {
      debugPrint("here is error from socket connection ${e.toString()}");
    }
    SharedText.currentTimerOfSocket =
        Timer.periodic(const Duration(seconds: 15), (timer) {
      _pingSocketJson();
    });
  }

  _pingSocketJson() {
    debugPrint("here is ping send from socket ${jsonEncode({
          "event": "pusher:ping",
          "data": "{}",
        })}");
    _webSocketChannel.sink.add(jsonEncode({
      "event": "pusher:ping",
      "data": jsonEncode({}),
    }));
  }

  void subScribeToChannelInSocket(String channelName) {
    debugPrint("responseOfChatAuth ${modelOfAuthInSocket.toString()}");
    _webSocketChannel.sink.add(
      jsonEncode(
        _handleSendEvent(
          eventData: {
            "auth": modelOfAuthInSocket.data["auth"],
            "channel_data": jsonEncode({
              "user_id": modelOfAuthInSocket.data["user_id"],
              "user_info": modelOfAuthInSocket.data["user_info"],
            }),
            "channel": channelName
          },
        ),
      ),
    );
  }

  void unSubScribeToChannelInSocket(String channelName) {
    debugPrint("responseOfChatAuth ${modelOfAuthInSocket.toString()}");
    _webSocketChannel.sink.add(
      jsonEncode(
        _handleSendEvent(
          eventName: "pusher:unsubscribe",
          eventData: {
            "auth": modelOfAuthInSocket.data["auth"],
            "channel_data": jsonEncode({
              "user_id": modelOfAuthInSocket.data["user_id"],
              "user_info": modelOfAuthInSocket.data["user_info"],
            }),
            "channel": channelName
          },
        ),
      ),
    );
  }

  Map<String, dynamic> _handleSendEvent({
    String eventName = "pusher:subscribe",
    required Map<String, dynamic> eventData,
    String? channelName,
  }) {
    Map<String, dynamic> sendMap = {
      "event": eventName,
      "data": eventData,
    };
    if (channelName != null) {
      sendMap.addAll({"channel": channelName});
    }
    debugPrint("here is your data to subscribe ${sendMap.toString()}");
    return sendMap;
  }

  void sendTypingToAnotherUser({
    required String userToId,
    required String userFromId,
    required bool isTyping,
  }) {
    _webSocketChannel.sink.add(
      jsonEncode(
        _handleSendEvent(
            eventName: "client-typing",
            eventData: {
              "from_id": userFromId,
              "to_id": userToId,
              "typing": isTyping
            },
            channelName: "private-chatify.$userToId"),
      ),
    );
  }
}
