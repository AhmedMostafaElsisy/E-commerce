import 'dart:convert';

import 'package:flutter/material.dart';

UserBaseEntity userBaseModelFromJson(String str) =>
    UserBaseEntity.fromJson(json.decode(str));

String userBaseModelToJson(UserBaseEntity data) => json.encode(data.toJson());

class UserBaseEntity {
  String? name;
  String? email;
  String? phone;
  String? address;
  int? active;
  int? verified;

  int? id;
  String? image;
  String? otp;
  String? rate;

  UserBaseEntity(
      {this.name,
      this.email,
      this.phone,
      this.address,
      this.active,
      this.verified,
      this.id,
      this.image,
      this.otp,
      this.rate});

  factory UserBaseEntity.fromJson(Map<String, dynamic> json) {
    try {
      return UserBaseEntity(
          name: json["name"],
          email: json["email"],
          phone: json["phone"],
          address: json["address"],
          active: json["active"],
          verified: json["verified"],
          id: json["id"],
          image: json["image"] ?? "",
          otp: json["otp"],
          rate: json["rate"] == null ? "0.0" : json["rate"].toString());
    } catch (e) {
      debugPrint("here is the error in parsing UserBaseModel ${e.toString()}");
      return UserBaseEntity();
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
    "rate":rate
      };
}
