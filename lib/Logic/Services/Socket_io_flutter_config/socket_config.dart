import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_io_socket/flutter_io_socket.dart';

class SocketConfig {
  late Socket socket;
  String baseUrl = 'http://localhost:3000';

  init() {
    socket = io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    connectAndListen();
  }

  disposeSocket() {
    socket.close();
    socket.dispose();
  }

  void connectAndListen() {
    socket.onConnect((_) => debugPrint('connect'));
    socket.onDisconnect((_) => debugPrint('disconnect'));
    socket.onError((_) => debugPrint('error'));
    socket.onConnecting((_) => debugPrint('connecting'));
    socket.onConnectError((_) => debugPrint('connect Error'));
    socket.onConnectTimeout((data) => debugPrint('timeout'));
    socket.on('connect_error', (value) {
      debugPrint('connect error ${value.toString()}');
    });

    /// 'event' must be the same channel name coming from backend
    socket.on('receive_message', (jsonData) {
      debugPrint('jsonData: ${jsonData.toString()}');
      // Map<String, dynamic> data = json.decode(jsonData);
      // String content = data['content'];
      // int senderChatID = data['senderChatID'];
      // int value = data['value'];
      // String text = data['text'];
    });

    //when sending message using emit
    Map<String, dynamic> map = <String, dynamic>{};
    map["message"] = "Hello";
    socket.emit('sendMessage', map);
  }

  void sendMessage(
      String content, int receiverChatID, int value, String text) async {
    int chatID = 1;

    Map<String, dynamic> map = <String, dynamic>{};
    map["receiverChatID"] = receiverChatID.toString();
    map["senderChatID"] = chatID.toString();
    map["content"] = content.toString();
    map["value"] = value.toString();
    map["text"] = text.toString();
    socket.emit('sendMessage', map);
  }
}
