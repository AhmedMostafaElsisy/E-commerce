
import 'package:flutter/cupertino.dart';

List<NotificationModel> notificationListFromJson(List str) =>
    List<NotificationModel>.from(str.map((x) => NotificationModel.fromJson(x)));

class NotificationModel {
  int? id;
  String? title;
  String? description;
  String? icon;
  bool? isRead;
  String? createdAt;

  NotificationModel({this.createdAt , this.id , this.isRead, this.icon , this.title , this.description,});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    try {
      return NotificationModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        icon: json["icon"],
        isRead: json["is_read"]==1? true:false,
        createdAt: json["date"],
      );
    } catch (e) {
      debugPrint("error when parsing review model ${e.toString()}");
      return NotificationModel();
    }
  }
}