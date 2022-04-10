import 'dart:convert';

import 'package:flutter/material.dart';

UserBaseModel userBaseModelFromJson(String str) =>
    UserBaseModel.fromJson(json.decode(str));

String userBaseModelToJson(UserBaseModel data) => json.encode(data.toJson());

class UserBaseModel {
  String? name;
  String? email;
  String? phone;
  String? address;
  int? active;
  int? verified;

  int? id;
  String? image;

  UserBaseModel(
      {this.name,
      this.email,
      this.phone,
      this.address,
      this.active,
      this.verified,

      this.id,
      this.image});

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
