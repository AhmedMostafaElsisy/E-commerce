import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../Domain/entities/base_user_entity.dart';
UserBaseEntity userBaseModelFromJson(String str) =>
    UserBaseModel.fromJson(json.decode(str));

String userBaseModelToJson(UserBaseModel data) => json.encode(data.toJson());

class UserBaseModel extends UserBaseEntity {
  UserBaseModel({
    String? name,
    String? email,
    String? phone,
    String? address,
    int? active,
    int? verified,
    int? id,
    String? image,
  }) : super(
            id: id,
            image: image,
            name: name,
            active: active,
            address: address,
            email: email,
            phone: phone,
            verified: verified);

  factory UserBaseModel.fromJson(Map<String, dynamic> json) {
    try {
      return UserBaseModel(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        active: json["active"],
        verified: json["verified"],
        id: json["id"],
        image: json["image"],
      );
    } catch (e) {
      debugPrint("here is the error in parsing UserBaseModel ${e.toString()}");
      return UserBaseModel();
    }
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
    "active": active,
    "verified": verified,
    "id": id,
    "image": image,
  };
}
