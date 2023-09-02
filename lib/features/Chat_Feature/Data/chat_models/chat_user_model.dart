import 'package:flutter/material.dart';

import '../../../../core/Error_Handling/parsing_exceptions.dart';
import '../../../Auth_feature/Data/model/base_user_model.dart';
import 'chat_model.dart';

List<ChatUserModel> chatUserListFromJson(List str) =>
    List<ChatUserModel>.from(str.map((x) => ChatUserModel.fromJson(x)));

class ChatUserModel {
  int id;
  String name;
  String? lastName;
  String? email;
  String? phone;
  String? image;
  bool? isFavorite;
  bool? isArchive;
  bool? isOnline;
  ChatMassageModel? lastMessage;

  ChatUserModel(
      {required this.id,
      required this.name,
      this.lastName,
      this.email,
      this.phone,
      this.image,
      this.isFavorite,
      this.isOnline,
      this.lastMessage,
      this.isArchive});

  factory ChatUserModel.fromJson(Map<String, dynamic> jsonObject) {
    debugPrint("here is your $jsonObject");
    try {
      return ChatUserModel(
          id: jsonObject["id"],
          name: jsonObject["name"],
          lastName: jsonObject["last_name"] ?? "--",
          email: jsonObject["email"] ?? "--",
          phone: jsonObject["phone"] ?? "--",
          image: jsonObject["avatar"] ?? "",
          isFavorite: jsonObject["is_favorite"] ?? false,
          isOnline: jsonObject["is_online"] == 1,
          lastMessage: jsonObject["last_message"] != null
              ? ChatMassageModel.fromJson(jsonObject["last_message"])
              : null,
          isArchive: jsonObject["is_archive"] ?? false);
    } catch (e) {
      debugPrint("error on parsing ChatUserModel${e.toString()}");
      throw ParsingException(errorException: e.toString());
    }
  }

  factory ChatUserModel.fromUserBaseModel(UserBaseModel userBaseModel) {
    try {
      return ChatUserModel(
        id: userBaseModel.id!,
        name: userBaseModel.name!,
        lastName: userBaseModel.name!,
        email: userBaseModel.email!,
        phone: userBaseModel.phone!,
        image: userBaseModel.image!,
        isFavorite: false,
      );
    } catch (e) {
      debugPrint("error on parsing ChatUserModel${e.toString()}");
      throw ParsingException(errorException: e.toString());
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "avatar": image,
        "is_favorite": isFavorite,
        "last_message": lastMessage,
      };

  String getMessageDependOnType() {
    if (lastMessage != null) {
      if (lastMessage!.massageContent != null &&
          lastMessage!.massageContent!.isNotEmpty) {
        return lastMessage!.massageContent!;
      } else if (lastMessage!.attachment != null &&
          lastMessage!.attachment!.isNotEmpty) {
        return lastMessage!.attachment!;
      }
    }
    return "--------";
  }
}
