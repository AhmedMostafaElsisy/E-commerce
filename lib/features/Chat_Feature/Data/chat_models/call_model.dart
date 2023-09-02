import 'package:flutter/material.dart';

import '../../../../core/Error_Handling/parsing_exceptions.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../Auth_feature/Data/model/base_user_model.dart';

class CallModel {
  UserBaseModel userToModel;
  UserBaseModel userFromModel;
  String? appID;
  String? channelName;
  String? agoraToken;
  int? uid;
  String type;
  String callToken;
  String? createdAt;

  CallModel({
    required this.userToModel,
    required this.userFromModel,
    required this.type,
    required this.callToken,
    this.appID,
    this.channelName,
    this.agoraToken,
    this.uid,
    this.createdAt,
  });

  factory CallModel.fromJson(Map<String, dynamic> jsonObject) {
    try {
      debugPrint("here is your created time $jsonObject");
      return CallModel(
        userToModel: UserBaseModel.fromJson(jsonObject["to"]),
        userFromModel: UserBaseModel.fromJson(jsonObject["from"]),
        appID: jsonObject["appID"],
        channelName: jsonObject["channelName"],
        agoraToken: jsonObject["token"],
        uid: jsonObject["uid"],
        type: jsonObject["type"],
        callToken: jsonObject["call_token"],
        createdAt: jsonObject["created_at"],
      );
    } catch (e) {
      debugPrint("error on parsing ChatUserModel${e.toString()}");
      throw ParsingException(errorException: e.toString());
    }
  }

  UserBaseModel getAnotherUser() {
    if (SharedText.currentUser?.id != userFromModel.id) {
      return userFromModel;
    } else {
      return userToModel;
    }
  }

  @override
  String toString() {
    return "call data is to: ${userToModel.id},from: ${userFromModel.id}, appID $appID, channelName $channelName, token: $agoraToken, uid: $uid, type $type, callToken $callToken";
  }
}
