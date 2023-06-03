import 'dart:convert';

import '../../../../../core/Constants/Enums/chat/socket_connection_enum.dart';
import '../../../../../core/Error_Handling/parsing_exceptions.dart';

class SocketModel {
  SocketEventEnum socketEventEnum;
  Map<String, dynamic>? eventData;
  String? channelName;

  SocketModel({
    required this.socketEventEnum,
    this.eventData,
    this.channelName,
  });

  factory SocketModel.fromJson(Map<String, dynamic> jsonObject) {
    try {
      SocketEventEnum getEventType(String type) {
        switch (type) {
          case 'pusher:connection_established':
            return SocketEventEnum.connectionEstablished;
          case 'client-typing':
            return SocketEventEnum.clientTyping;
          case 'client-contactItem':
            return SocketEventEnum.clientContactItem;

          default:
            return SocketEventEnum.init;
        }
      }

      parseObjectDependOnType({required Map<String, dynamic> jsonObject}) {
        return jsonObject["data"].runtimeType == String
            ? jsonDecode(jsonObject["data"])
            : jsonObject["data"];
      }

      return SocketModel(
        socketEventEnum: getEventType(jsonObject["event"]),
        channelName: jsonObject["channel"],
        eventData: jsonObject["data"] == null
            ? null
            : parseObjectDependOnType(jsonObject: jsonObject),
      );
    } catch (e) {
      throw ParsingException(errorException: e.toString());
    }
  }

  bool isTypingWithThisUser({required String peerUserId}) {
    return eventData?["typing"] &&
        eventData?["from_id"].toString() == peerUserId;
  }

  bool isUpdatingWithThisUser({required String peerUserId}) {
    return eventData?["updating"] &&
        eventData?["update_to"].toString() == peerUserId;
  }

  @override
  String toString() {
    return "SocketModel-> event:${socketEventEnum.toString()} , dataOfEvent: ${eventData.toString()} ";
  }
}
