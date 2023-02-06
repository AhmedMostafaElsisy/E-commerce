import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../Domain/entities/base_user_entity.dart';
import 'location_model.dart';

UserBaseEntity userBaseModelFromJson(String str) =>
    UserBaseModel.fromJson(json.decode(str));

String userBaseModelToJson(UserBaseModel data) => json.encode(data.toJson());

class UserBaseModel extends UserBaseEntity {
  UserBaseModel({
    String? name,
    String? email,
    String? phone,
    LocationModel? address,
    int? active,
    int? verified,
    int? id,
    String? image,
    String? otp,
  }) : super(
            id: id,
            image: image,
            name: name,
            active: active,
            locationModel: address,
            email: email,
            phone: phone,
            verified: verified,
            otp: otp);

  factory UserBaseModel.fromJson(Map<String, dynamic> json) {
    try {
      return UserBaseModel(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: LocationModel.fromJson(json["location"]),
        active: json["active"],
        verified: json["verified"],
        id: json["id"],
        image: json["image"],
        otp: json["otp"],
      );
    } catch (e) {
      debugPrint("here is the error in parsing UserBaseModel ${e.toString()}");
      return UserBaseModel();
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "location": locationModel!.toJson(),
        "active": active,
        "verified": verified,
        "id": id,
        "image": image,
      };
}
