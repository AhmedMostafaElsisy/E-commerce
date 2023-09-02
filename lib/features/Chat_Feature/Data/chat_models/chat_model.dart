import 'package:captien_omda_customer/core/Extensions/format_date_time_to_time_only.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/Constants/Enums/chat/massage_type.dart';

List<ChatMassageModel> chatMassageListFromJson(List str) =>
    List<ChatMassageModel>.from(str.map((x) => ChatMassageModel.fromJson(x)));

class ChatMassageModel {
  int? receiverId;
  int? senderID;
  int? massageId;
  String? massageContent;
  String? attachment;
  MassageType? massageType;
  bool? isLocal;
  bool? isSeen;
  String? dateOfCreation;

  ChatMassageModel({
    this.receiverId,
    this.massageContent,
    this.massageType,
    this.isLocal,
    this.attachment,
    this.massageId,
    this.senderID,
    this.isSeen = false,
    this.dateOfCreation,
  });

  factory ChatMassageModel.fromJson(Map<String, dynamic> json) {
    debugPrint("here is message content${json.toString()}");
    getMassageTypeFromBody(String body) {
      if (body == "") return null;
      if (body.contains("https://maps.google.com/")) return "location";
      return null;
    }

    return ChatMassageModel(
        massageId: json["id"],
        receiverId: json["to_id"],
        senderID: json["from_id"],
        massageContent: json["body"],
        attachment: json["attachment"] ?? "",
        massageType: MassageType.values.byName(
          getMassageTypeFromBody(json["body"]) ??
              json["attachment_type"] ??
              "text",
        ),
        isSeen: json["seen"] == 1,
        isLocal: false,
        dateOfCreation:
            DateTime.parse(json["created_at"]).formatDateTimeToChat());
  }

  @override
  String toString() {
    // TODO: implement toString
    return "chat massage -> massageId $massageId, receiverId $receiverId senderID $senderID, massageContent $massageContent";
  }
}
