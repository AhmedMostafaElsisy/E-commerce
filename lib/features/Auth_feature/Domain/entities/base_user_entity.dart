import 'dart:convert';

import 'package:flutter/material.dart';

import '../../Data/model/location_model.dart';

UserBaseEntity userBaseModelFromJson(String str) =>
    UserBaseEntity.fromJson(json.decode(str));

String userBaseModelToJson(UserBaseEntity data) => json.encode(data.toJson());

class UserBaseEntity {
  String? name;
  String? email;
  String? phone;
  int? active;
  int? verified;
  int? id;
  String? image;
  String? otp;
  String? rate;
  LocationModel? locationModel;

  UserBaseEntity(
      {this.name,
      this.email,
      this.phone,
      this.locationModel,
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
          locationModel: LocationModel.fromJson(json["location"]),
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
        "location": locationModel!.toJson(),
        "active": active,
        "verified": verified,
        "id": id,
        "image": image,
        "rate": rate
      };

  @override
  String toString() {
    return 'UserBaseEntity{name: $name, email: $email, phone: $phone, active: $active, verified: $verified, id: $id, image: $image, otp: $otp, rate: $rate, locationModel: $locationModel}';
  }
}
